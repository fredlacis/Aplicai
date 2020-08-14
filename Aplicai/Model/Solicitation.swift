//
//  Solicitation.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 13/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import Foundation
import CloudKit

struct Solicitation: CloudRecord {
    
    enum Status: Int {
        case waiting = 0
        case accepted = 1
        case rejected = 2
    }
    
    // CloudRecord
    var recordName: String?
    
    // Relationship
    var demand: Demand
    var student: User
    
    // Atributes
    var motivationText: String
    var status: Int = Status.waiting.rawValue
    
    // Empty Solicitation
    private static var empty: Solicitation {
        Solicitation(demand: Demand.empty, student: User.emptyStudent, motivationText: "")
    }

}

// CloudKit methods
extension Solicitation {
    
    func ckSave(then completion:@escaping (Result<Solicitation, Error>)->Void) {
        
        var solicitationRecord: CKRecord?
        
        if self.recordName == nil {
            do {
                solicitationRecord = try self.asCKRecord()
                dump(solicitationRecord)
            } catch let error {
                completion(.failure(error))
                return
            }
        } else {
            CKDefault.database.fetch(withRecordID: CKRecord.ID(recordName: self.recordName!), completionHandler: { (record, error) -> Void in
                if let error = error {
                    print("Error on fetching solicitation to update: ", error)
                    completion(.failure(error))
                } else if let record = record {
                    solicitationRecord = record
                }
                CKDefault.semaphore.signal()
            })
            CKDefault.semaphore.wait()
            solicitationRecord!["status"] = self.status
        }
        
        CKDefault.database.save(solicitationRecord!, completionHandler: { (record,error) -> Void in
            if let error = error {
                completion(.failure(error))
                return
            } else if let record = record {
                let solicitationResult = Self.parseSolicitation(record: record)
                if let solicitationResult = solicitationResult {
                    completion(.success(solicitationResult))
                }
            }
        })
    }
    
    static func ckLoadByDemand(demandRecordName: String, then completion:@escaping (Result<[Solicitation], Error>)->Void) {
        let demandReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: demandRecordName), action: .none)
        let pred = NSPredicate(format: "demand == %@", demandReference)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        let query = CKQuery(recordType: Self.ckRecordType, predicate: pred)
        query.sortDescriptors = [sort]
        CKDefault.database.perform(query, inZoneWith: nil, completionHandler: { (records, error) -> Void in
            if let error = error {
                completion(.failure(error))
                return
            } else if let records = records {
                var result: [Solicitation] = []
                for record in records {
                    let solicitationResult = Self.parseSolicitation(record: record)
                    if let solicitationResult = solicitationResult {
                        result.append(solicitationResult)
                    }
                }
                CKDefault.addToCache(records)
                completion(.success(result))
            }
        })
    }
    
    static func ckLoadByUser(userRecordName: String, then completion:@escaping (Result<[Solicitation], Error>)->Void){
        let userReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: userRecordName), action: .none)
        let pred = NSPredicate(format: "student == %@", userReference)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        let query = CKQuery(recordType: Self.ckRecordType, predicate: pred)
        query.sortDescriptors = [sort]
        CKDefault.database.perform(query, inZoneWith: nil, completionHandler: { (records, error) -> Void in
            if let error = error {
                completion(.failure(error))
                return
            } else if let records = records {
                var result: [Solicitation] = []
                for record in records {
                    let solicitationResult = Self.parseSolicitation(record: record)
                    if let solicitationResult = solicitationResult {
                        result.append(solicitationResult)
                    }
                }
                CKDefault.addToCache(records)
                completion(.success(result))
            }
        })
    }
    
    static func ckLoadByUserAndDemand(userRecordName: String, demandRecordName: String, then completion:@escaping (Result<Solicitation?, Error>)->Void){
        let userReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: userRecordName), action: .none)
        let demandReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: demandRecordName), action: .none)
        let pred = NSPredicate(format: "student == %@ && demand == %@", userReference, demandReference)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        let query = CKQuery(recordType: Self.ckRecordType, predicate: pred)
        query.sortDescriptors = [sort]
        CKDefault.database.perform(query, inZoneWith: nil, completionHandler: { (records, error) -> Void in
            if let error = error {
                completion(.failure(error))
                return
            } else if let records = records {
                var result: [Solicitation] = []
                for record in records {
                    let solicitationResult = Self.parseSolicitation(record: record)
                    if let solicitationResult = solicitationResult {
                        result.append(solicitationResult)
                    }
                }
                CKDefault.addToCache(records)
                if result.isEmpty {
                    completion(.success(nil))
                } else {
                    completion(.success(result[0]))
                }
            }
        })
    }
    
    static func parseSolicitation(record: CKRecord) -> Solicitation? {
        let dispatchGroup = DispatchGroup()
        
        var newSolicitation: Solicitation = Solicitation.empty
        
        newSolicitation.recordName = record.recordID.recordName
        
        let userReference = record["student"] as! CKRecord.Reference
        
        dispatchGroup.enter()
        User.ckLoadByUserID(userID: userReference.recordID, then: { (record) -> Void in
            switch record {
                case .success(let record):
                    newSolicitation.student = record
                    dispatchGroup.leave()
                case .failure(let error):
                    debugPrint("Error on parseSolicitation, user not found.", error)
                    dispatchGroup.leave()
            }
        })
        
        let demandReference = record["demand"] as! CKRecord.Reference
        
        dispatchGroup.enter()
        Demand.ckLoadById(with: demandReference.recordID, then: { (record) -> Void in
            switch record {
                case .success(let record):
                    newSolicitation.demand = record
                    dispatchGroup.leave()
                case .failure(let error):
                    debugPrint("Error on parseSolicitation, demand not found.", error)
                    dispatchGroup.leave()
            }
        })
        
        dispatchGroup.wait()
        
        if newSolicitation.demand == Demand.empty || newSolicitation.student == User.emptyStudent{
            return nil
        }
        
        newSolicitation.motivationText = record["motivationText"] as! String
        newSolicitation.status = record["status"] as! Int
        
        return newSolicitation
    }
    
}
