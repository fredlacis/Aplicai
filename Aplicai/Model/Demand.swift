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

struct Demand: CloudRecord {

    var recordName: String?
//    var id = UUID()
    var ownerUser: User
//    var solicitations: [User]?
//    var participants: [User]?
    var title: String
    var businessName: String
    var categorys: [String]
    var location: String
    var image: Data?
    var estimatedDuration: String
    var deadline: Date
    var groupSize: Int
    var description: String
    
    static var empty : Demand{
        return Demand(ownerUser: User.emptyBusiness, title: "", businessName: "", categorys: [""], location: "", estimatedDuration: "Média", deadline: Date(), groupSize: 0, description: "")
    }
    
    func ckSave(then completion:@escaping (Result<Demand, Error>)->Void) {
            var record:CKRecord
            do {
                record = try self.asCKRecord()
            } catch let error {
                completion(.failure(error))
                return
            }
            CKDefault.database.save(record, completionHandler: {
                (record,error) -> Void in
                if let error = error {
                    completion(.failure(error))
                    return
                } else if let record = record {
                    completion(.success(Self.parseDemand(record: record)))
                }
            })
        }
    
    static func ckLoad(with recordID: CKRecord.ID, then completion: @escaping (Result<Demand, Error>) -> Void) {
        
        CKDefault.database.fetch(withRecordID: recordID, completionHandler: { (record, error) -> Void in
            // Got error
            if let error = error {
                completion(.failure(error))
                return
            }
            // else
            if let record = record {
                let result: Demand = Self.parseDemand(record: record)
                completion(.success(result))
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
                    result.append(Self.parseDemand(record: record))
                }
                
                guard records.count == result.count else {
                    print("Erro bem aqui")
                    completion(.failure(CRUDError.cannnotMapAllRecords))
                    return
                }
                
                completion(.success(result))
            }
        })
        
    }
    
    static func parseDemand(record: CKRecord) -> Demand {
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
        
        if let demandImage = record["image"] as? CKAsset {
            newDemand.image = demandImage.fileURL?.contentAsData
        }
        
        newDemand.title = record["title"] as! String
        newDemand.businessName = record["businessName"] as! String
        newDemand.categorys = record["categorys"] as! [String]
        newDemand.location = record["location"] as! String
//        newDemand.image = record["image"] as! String
        newDemand.estimatedDuration = record["estimatedDuration"] as! String
        newDemand.deadline = record["deadline"] as! Date
        newDemand.groupSize = record["groupSize"] as! Int
        newDemand.description = record["description"] as! String
        
        return newDemand
    }

}

var testData: [Demand] = [
    Demand(ownerUser: User.emptyBusiness, title: "Site oficial da padaria", businessName: "Padaria Bacana", categorys: ["Ciência da Computação", "Design"], location: "Rio de Janeiro", estimatedDuration: "Média Duração", deadline: Date(), groupSize: 2, description: "Seu Zé reparou na quarentena de que seria preciso divulgar os seus bolos, doces e salgados de por meio de um site para maior visualização de seu trabalho. Gostaria de ter em seu site uma divulgação de todos os seus produtos, além de um contato para delivery."),
    Demand(ownerUser: User.emptyBusiness, title: "Dar aulas de robótica para crianças via zoom", businessName: "Robótica do Bem", categorys: ["Engenharia Elétrica"], location: "Rio de Janeiro", estimatedDuration: "Média Duração", deadline: Date(), groupSize: 3, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu."),
    Demand(ownerUser: User.emptyBusiness, title: "Criar obras de arte mecânicas", businessName: "MASP", categorys: ["Engenharia", "Design"], location: "São Paulo", estimatedDuration: "Curta Duração", deadline: Date(), groupSize: 1, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu. Nulla ante ante, volutpat sed vehicula vulputate, maximus in libero. Integer eu finibus justo. Sed quis felis sed mi cursus efficitur ac eu lacus. Pellentesque cursus libero ac nunc condimentum, eu scelerisque est semper. Pellentesque consequat lacus ut luctus convallis. Quisque blandit orci ac odio posuere pellentesque. Aliquam erat volutpat."),
    Demand(ownerUser: User.emptyBusiness, title: "Desenvolver software para controle de estoque", businessName: "Loiola Construções", categorys: ["Administração", "Computação", "Engenharia"], location: "São Paulo", estimatedDuration: "Longa Duração", deadline: Date(), groupSize: 6, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu. Nulla ante ante, volutpat sed vehicula vulputate, maximus in libero. Integer eu finibus justo. Sed quis felis sed mi cursus efficitur ac eu lacus. Pellentesque cursus libero ac nunc condimentum, eu scelerisque est semper. Pellentesque consequat lacus ut luctus convallis. Quisque blandit orci ac odio posuere pellentesque. Aliquam erat volutpat.")
//    Demand(title: "Dar aulas de robótica para crianças via zoom", businessName: "Robótica do Bem", categorys: ["Engenharia Elétrica"], location: "Rio de Janeiro", image: "image1", estimatedDuration: "Média Duração", deadline: Date(), groupSize: 3, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu."),
//    Demand(title: "Criar obras de arte mecanicas", businessName: "MASP", categorys: ["Engenharia", "Design"], location: "São Paulo", image: "image2", estimatedDuration: "Curta Duração", deadline: Date(), groupSize: 1, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu. Nulla ante ante, volutpat sed vehicula vulputate, maximus in libero. Integer eu finibus justo. Sed quis felis sed mi cursus efficitur ac eu lacus. Pellentesque cursus libero ac nunc condimentum, eu scelerisque est semper. Pellentesque consequat lacus ut luctus convallis. Quisque blandit orci ac odio posuere pellentesque. Aliquam erat volutpat."),
//    Demand(title: "Desenvolver software para controle de estoque", businessName: "Loiola Construções", categorys: ["Administração", "Computação", "Engenharia"], location: "São Paulo", image: "image3", estimatedDuration: "Longa Duração", deadline: Date(), groupSize: 6, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu. Nulla ante ante, volutpat sed vehicula vulputate, maximus in libero. Integer eu finibus justo. Sed quis felis sed mi cursus efficitur ac eu lacus. Pellentesque cursus libero ac nunc condimentum, eu scelerisque est semper. Pellentesque consequat lacus ut luctus convallis. Quisque blandit orci ac odio posuere pellentesque. Aliquam erat volutpat."),
//    Demand(title: "Dar aulas de robótica para crianças via zoom", businessName: "Robótica do Bem", categorys: ["Engenharia Elétrica"], location: "Rio de Janeiro", image: "image1", estimatedDuration: "Média Duração", deadline: Date(), groupSize: 3, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu."),
//    Demand(title: "Criar obras de arte mecanicas", businessName: "MASP", categorys: ["Engenharia", "Design"], location: "São Paulo", image: "image2", estimatedDuration: "Curta Duração", deadline: Date(), groupSize: 1, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu. Nulla ante ante, volutpat sed vehicula vulputate, maximus in libero. Integer eu finibus justo. Sed quis felis sed mi cursus efficitur ac eu lacus. Pellentesque cursus libero ac nunc condimentum, eu scelerisque est semper. Pellentesque consequat lacus ut luctus convallis. Quisque blandit orci ac odio posuere pellentesque. Aliquam erat volutpat."),
//    Demand(title: "Desenvolver software para controle de estoque", businessName: "Loiola Construções", categorys: ["Administração", "Computação", "Engenharia"], location: "São Paulo", image: "image3", estimatedDuration: "Longa Duração", deadline: Date(), groupSize: 6, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu. Nulla ante ante, volutpat sed vehicula vulputate, maximus in libero. Integer eu finibus justo. Sed quis felis sed mi cursus efficitur ac eu lacus. Pellentesque cursus libero ac nunc condimentum, eu scelerisque est semper. Pellentesque consequat lacus ut luctus convallis. Quisque blandit orci ac odio posuere pellentesque. Aliquam erat volutpat.")
]

//
//let videoDemads: [Demand] = [
//    Demand(title: "Site oficial da padaria", businessName: "Padaria Bacana", categorys: ["Ciência da Computação", "Design"], location: "Rio de Janeiro", image: "demandaSeuZe", estimatedDuration: "Média Duração", deadline: Date(), groupSize: 2, description: "Seu Zé reparou na quarentena de que seria preciso divulgar os seus bolos, doces e salgados de por meio de um site para maior visualização de seu trabalho. Gostaria de ter em seu site uma divulgação de todos os seus produtos, além de um contato para delivery.")
//]
//
//let cassandra: [Demand] = [
//    Demand(title: "Dar aulas de robótica para crianças via zoom", businessName: "Robótica do Bem", categorys: ["Engenharia Elétrica"], location: "Rio de Janeiro", image: "image1", estimatedDuration: "Média Duração", deadline: Date(), groupSize: 3, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu.")
//]
