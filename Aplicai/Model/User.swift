//
//  Users.swift
//  cloudKitAplicaiTest
//
//  Created by Frederico Lacis de Carvalho on 06/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import Foundation
import CloudKit

struct User: CloudRecord {
    
    var recordName: String?
    
    var userID: String?
    
    var accountType: String
    
    //Global
    var name: String
    var email: String
    
    //For student
    var course: String = ""
    var cpf: String = ""
    var registrationNumber: String = ""
    
    //For business
    var cnpj: String = ""
    var companyName: String = ""
    var functionDescription: String = ""
    
    static var emptyStudent: User {
        return User(accountType: "student", name: "", email: "", course: "", cpf: "", registrationNumber: "")
    }
    
    static var emptyBusiness: User {
        return User(accountType: "business", name: "", email: "", cnpj: "", companyName: "", functionDescription: "")
    }
        
    static func ckLoadByUserID(then completion:@escaping (Result<Any, Error>)->Void) {
        //Fetching userID
        var currentUserID: String?
        CKDefault.container.fetchUserRecordID(completionHandler: { (record, error)->Void in
            if let record = record {
//                print("SUCCESS | UserID: ", record.recordName)
                currentUserID = record.recordName
                
                //Preparara a query
                let predicate = NSPredicate(format: "userID == %@", currentUserID!)
                let query = CKQuery(recordType: Self.ckRecordType, predicate: predicate)
                
                
                // Executar a query
                CKDefault.database.perform(query, inZoneWith: nil, completionHandler: { (records, error) -> Void in
                    
                    // Got error
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    // else
                    if let records = records {
                        let result:[Self] = records.compactMap{try? Self.load(from: $0.asDictionary)}
                        
                        guard records.count == result.count else {
                            completion(.failure(CRUDError.cannnotMapAllRecords))
                            return
                        }
                        CKDefault.addToCache(records)
                        completion(.success(result))
                    }
                    
                })
                
            }
            if let error = error {
                debugPrint(error)
                return
            }
        })
        
    }
    
}