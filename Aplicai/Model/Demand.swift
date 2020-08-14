//
//  Demand.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 24/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

var testData: [Demand] = [
    Demand(ownerUser: User.emptyBusiness, title: "Site oficial da padaria", categorys: ["Ciência da Computação", "Design"], location: "Rio de Janeiro", estimatedDuration: "Média Duração", deadline: Date(), groupSize: 2, description: "Seu Zé reparou na quarentena de que seria preciso divulgar os seus bolos, doces e salgados de por meio de um site para maior visualização de seu trabalho. Gostaria de ter em seu site uma divulgação de todos os seus produtos, além de um contato para delivery."),
    Demand(ownerUser: User.emptyBusiness, title: "Dar aulas de robótica para crianças via zoom", categorys: ["Engenharia Elétrica"], location: "Rio de Janeiro", estimatedDuration: "Média Duração", deadline: Date(), groupSize: 3, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu."),
    Demand(ownerUser: User.emptyBusiness, title: "Criar obras de arte mecânicas", categorys: ["Engenharia", "Design"], location: "São Paulo", estimatedDuration: "Curta Duração", deadline: Date(), groupSize: 1, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu. Nulla ante ante, volutpat sed vehicula vulputate, maximus in libero. Integer eu finibus justo. Sed quis felis sed mi cursus efficitur ac eu lacus. Pellentesque cursus libero ac nunc condimentum, eu scelerisque est semper. Pellentesque consequat lacus ut luctus convallis. Quisque blandit orci ac odio posuere pellentesque. Aliquam erat volutpat."),
    Demand(ownerUser: User.emptyBusiness, title: "Desenvolver software para controle de estoque", categorys: ["Administração", "Computação", "Engenharia"], location: "São Paulo", estimatedDuration: "Longa Duração", deadline: Date(), groupSize: 6, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu. Nulla ante ante, volutpat sed vehicula vulputate, maximus in libero. Integer eu finibus justo. Sed quis felis sed mi cursus efficitur ac eu lacus. Pellentesque cursus libero ac nunc condimentum, eu scelerisque est semper. Pellentesque consequat lacus ut luctus convallis. Quisque blandit orci ac odio posuere pellentesque. Aliquam erat volutpat.")
//    Demand(title: "Dar aulas de robótica para crianças via zoom", businessName: "Robótica do Bem", categorys: ["Engenharia Elétrica"], location: "Rio de Janeiro", image: "image1", estimatedDuration: "Média Duração", deadline: Date(), groupSize: 3, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu."),
//    Demand(title: "Criar obras de arte mecanicas", businessName: "MASP", categorys: ["Engenharia", "Design"], location: "São Paulo", image: "image2", estimatedDuration: "Curta Duração", deadline: Date(), groupSize: 1, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu. Nulla ante ante, volutpat sed vehicula vulputate, maximus in libero. Integer eu finibus justo. Sed quis felis sed mi cursus efficitur ac eu lacus. Pellentesque cursus libero ac nunc condimentum, eu scelerisque est semper. Pellentesque consequat lacus ut luctus convallis. Quisque blandit orci ac odio posuere pellentesque. Aliquam erat volutpat."),
//    Demand(title: "Desenvolver software para controle de estoque", businessName: "Loiola Construções", categorys: ["Administração", "Computação", "Engenharia"], location: "São Paulo", image: "image3", estimatedDuration: "Longa Duração", deadline: Date(), groupSize: 6, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu. Nulla ante ante, volutpat sed vehicula vulputate, maximus in libero. Integer eu finibus justo. Sed quis felis sed mi cursus efficitur ac eu lacus. Pellentesque cursus libero ac nunc condimentum, eu scelerisque est semper. Pellentesque consequat lacus ut luctus convallis. Quisque blandit orci ac odio posuere pellentesque. Aliquam erat volutpat."),
//    Demand(title: "Dar aulas de robótica para crianças via zoom", businessName: "Robótica do Bem", categorys: ["Engenharia Elétrica"], location: "Rio de Janeiro", image: "image1", estimatedDuration: "Média Duração", deadline: Date(), groupSize: 3, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu."),
//    Demand(title: "Criar obras de arte mecanicas", businessName: "MASP", categorys: ["Engenharia", "Design"], location: "São Paulo", image: "image2", estimatedDuration: "Curta Duração", deadline: Date(), groupSize: 1, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu. Nulla ante ante, volutpat sed vehicula vulputate, maximus in libero. Integer eu finibus justo. Sed quis felis sed mi cursus efficitur ac eu lacus. Pellentesque cursus libero ac nunc condimentum, eu scelerisque est semper. Pellentesque consequat lacus ut luctus convallis. Quisque blandit orci ac odio posuere pellentesque. Aliquam erat volutpat."),
//    Demand(title: "Desenvolver software para controle de estoque", businessName: "Loiola Construções", categorys: ["Administração", "Computação", "Engenharia"], location: "São Paulo", image: "image3", estimatedDuration: "Longa Duração", deadline: Date(), groupSize: 6, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu. Nulla ante ante, volutpat sed vehicula vulputate, maximus in libero. Integer eu finibus justo. Sed quis felis sed mi cursus efficitur ac eu lacus. Pellentesque cursus libero ac nunc condimentum, eu scelerisque est semper. Pellentesque consequat lacus ut luctus convallis. Quisque blandit orci ac odio posuere pellentesque. Aliquam erat volutpat.")
]

struct Demand: CloudRecord {

    var recordName: String?

    var ownerUser: User
//    var participants: [User]?
    var title: String
    var categorys: [String]
    var location: String
    var image: Data?
    var estimatedDuration: String
    var deadline: Date
    var groupSize: Int
    var description: String
    var isFinished: Int = IsFinished.no.rawValue
    
    static var empty : Demand{
        return Demand(ownerUser: User.emptyBusiness, title: "", categorys: [""], location: "", estimatedDuration: "Média", deadline: Date(), groupSize: 0, description: "")
    }
    
    enum IsFinished: Int {
        case no = 0
        case yes = 1
    }

}

// CloudKit methods
extension Demand {
    
    func ckSave(then completion:@escaping (Result<Demand, Error>)->Void) {
        var demandRecord: CKRecord?
        
        if self.recordName == nil {
            do {
                demandRecord = try self.asCKRecord()
            } catch let error {
                completion(.failure(error))
                return
            }
        } else {
            CKDefault.database.fetch(withRecordID: CKRecord.ID(recordName: self.recordName!), completionHandler: { (record, error) -> Void in
                if let error = error {
                    print("Error on fetching demand to update: ", error)
                    completion(.failure(error))
                } else if let record = record {
                    demandRecord = record
                }
                CKDefault.semaphore.signal()
            })
            CKDefault.semaphore.wait()
            demandRecord!["isFinished"] = self.isFinished
        }
        
        
        CKDefault.database.save(demandRecord!, completionHandler: {
            (record,error) -> Void in
            if let error = error {
                completion(.failure(error))
                return
            } else if let record = record {
                let demandResult = Self.parseDemand(record: record)
                if let demandResult = demandResult {
                    completion(.success(demandResult))
                }
            }
        })
    }
    
    static func ckLoadById(with recordID: CKRecord.ID, then completion: @escaping (Result<Demand, Error>) -> Void) {
        CKDefault.database.fetch(withRecordID: recordID, completionHandler: { (record, error) -> Void in
            // Got error
            if let error = error {
                completion(.failure(error))
                return
            } else if let record = record {
                let demandResult = Self.parseDemand(record: record)
                if let demandResult = demandResult {
                    completion(.success(demandResult))
                }
            }
        })
        
    }
    
    static func ckLoadAllDemands(sortedBy sortKeys:[CKSortDescriptor] = [], then completion:@escaping (Result<[Demand], Error>)->Void) {
        
        //Preparara a query
        let predicate = NSPredicate(value:true)
        let query = CKQuery(recordType: Self.ckRecordType, predicate: predicate)
        query.sortDescriptors = sortKeys.ckSortDescriptors
        
        
        // Executar a query
        CKDefault.database.perform(query, inZoneWith: nil, completionHandler: { (records, error) -> Void in
            // Got error
            if let error = error {
                completion(.failure(error))
                return
            }
            // else
            if let records = records {
                var result: [Demand] = []
                
                for record in records {
                    let demandResult = Self.parseDemand(record: record)
                    if let demandResult = demandResult {
                        result.append(demandResult)
                    }
                }
                
                //                guard records.count == result.count else {
                //                    print("Erro bem aqui")
                //                    completion(.failure(CRUDError.cannnotMapAllRecords))
                //                    return
                //                }
                
                if result.count == 0 {
                    print("No demands available")
                }
                
                completion(.success(result))
            }
        })
        
    }
    
    static func ckLoadByOwner(ownerRecordName: String, then completion:@escaping (Result<[Demand], Error>)->Void) {
        let ownerReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: ownerRecordName), action: .none)
        let pred = NSPredicate(format: "ownerUser == %@", ownerReference)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        let query = CKQuery(recordType: Self.ckRecordType, predicate: pred)
        query.sortDescriptors = [sort]
        CKDefault.database.perform(query, inZoneWith: nil, completionHandler: { (records, error) -> Void in
            if let error = error {
                completion(.failure(error))
                return
            } else if let records = records {
                var result: [Demand] = []
                for record in records {
                    let demandResult = Self.parseDemand(record: record)
                    if let demandResult = demandResult {
                        result.append(demandResult)
                    }
                }
                if result.count == 0 {
                    print("No demands available")
                }
                completion(.success(result))
            }
        })
        
    }
    
    static func parseDemand(record: CKRecord) -> Demand? {
        
        var newDemand: Demand = Demand.empty
        
        newDemand.recordName = record.recordID.recordName
        
        let userReference = record["ownerUser"] as! CKRecord.Reference
        User.ckLoadByUserID(userID: userReference.recordID, then: { (record) -> Void in
            switch record {
            case .success(let record):
                newDemand.ownerUser = record
            case .failure(let error):
                debugPrint("Error on ParseDemand, user not found.", error)
            }
            CKDefault.semaphore.signal()
        })
        CKDefault.semaphore.wait()
        
        if newDemand.ownerUser == User.emptyBusiness {
            return nil
        }
        
        if let demandImage = record["image"] as? CKAsset {
            newDemand.image = demandImage.fileURL?.contentAsData
        }
        
        newDemand.title = record["title"] as! String
        newDemand.categorys = record["categorys"] as! [String]
        newDemand.location = record["location"] as! String
        newDemand.estimatedDuration = record["estimatedDuration"] as! String
        newDemand.deadline = record["deadline"] as! Date
        newDemand.groupSize = record["groupSize"] as! Int
        newDemand.description = record["description"] as! String
        newDemand.isFinished = record["isFinished"] as! Int

        return newDemand
    }
    
}
