//
//  Protocols.swift
//  CloudKitExample
//
//  Created by Ricardo Venieris on 28/07/20.
//  Copyright © 2020 Ricardo Venieris. All rights reserved.
//

import CloudKit

protocol CKCloudable:Codable {
    var recordName:String? { get set }
    //init(from:CKRecord)
}
protocol CloudRecord: CKCloudable, Hashable {
    
}

extension CKCloudable {
    static var ckRecordType: String {
        get { CKDefault.getRecordTypeFor(type: Self.self) }
        set { CKDefault.setRecordTypeFor(type: Self.self, recordName: newValue) }
    }
    
    static var ckIsCachable:Bool {
        get { CKDefault.get(isCacheable: Self.self) }
        set { CKDefault.set(type: Self.self, isCacheable: newValue) }
    }
    
    var reference:CKRecord.Reference? {
        guard let recordName = self.recordName else {return nil}
        return CKRecord.Reference(recordID: CKRecord.ID(recordName: recordName), action: .none)
        
    }
    
    var referenceSavingRecordIfNull:CKRecord.Reference? {
        if let reference = self.reference {return reference}
        // else
        var savedReference:CKRecord.Reference? = nil
        
        // Inicio assincrono
        self.ckSave(then: { result in
            switch result {
                case .success(let savedRecord):
                    savedReference = (savedRecord as? CKCloudable)?.reference
                case .failure(let error):
                    debugPrint("error saving record \(self.recordName ?? "without recordName") \n\(error)")
            }
            CKDefault.semaphore.signal()
        })
        // fim assincrono
        CKDefault.semaphore.wait()

        return savedReference
        
    }
    
    func asCKRecord()throws ->CKRecord {
        let ckRecord = CKRecord(recordType: Self.ckRecordType)
        let mirror = Mirror(reflecting: self)
        
        
//        print("class \(mirror.subjectType) {")
        for field in mirror.children{
            // Trata valores à partir dde um mirroing
            
            var value = field.value
            guard !"\(value)".elementsEqual("nil") else {continue} // se valor nil nem perde tempo
            guard let key = field.label else { fatalError("Type \(mirror) have field without label.") }
//            print("    \(key): \(type(of: field.value)) = \(field.value)")

            //MARK: Tratamento de todos os tipos possíveis
            
            // Se o campo é um básico (Numero, String, Date ou Array desses elementos)
            if  isBasicType(field.value) {
                ckRecord.setValue(value, forKey: key)
            }
                
                // Se o campo é Data ou [Data], converte pra Asset ou [Asset]
            else if let data = value as? Data {
                value = CKAsset(data: data)
                ckRecord.setValue(value, forKey: key)
            }
                
            else if let datas = value as? [Data] {
                value = datas.map {CKAsset(data: $0)}
                ckRecord.setValue(value, forKey: key)
            }
                
                // se campo é CKCloudable, pega a referência
            else if let value = field.value as? CKCloudable {
                if let reference = value.referenceSavingRecordIfNull {
                    ckRecord.setValue(reference, forKey: key)
                } else {
                    // TODO: Salvar o objeto não salvo e colocar um semáforo para esperar
                    debugPrint("Field refference was't saved before\(key) \n Data:")
                    dump(value)
                    throw CRUDError.noSurchRecord
                }
                
            }
                
                // se campo é [CKCloudable] Pega a referência
            else if let value = field.value as? [CKCloudable] {
                var references:[CKRecord.Reference] = []
                for item in value {
                    if let reference = item.referenceSavingRecordIfNull {
                        references.append(reference)
                    } else {
                        debugPrint("Invalid Field in \(mirror).\(key) \n Data:")
                        dump(item)
                        throw CRUDError.invalidRecordID
                    }
                }
                ckRecord.setValue(references, forKey: key)
                
            }
                
            else {
                debugPrint("WARNING: Untratable type\n    \(key): \(type(of: field.value)) = \(field.value)")
                continue
            }
        }
        return ckRecord
    }
    
    /// Save the Object in iCloud returning the New Saved Object or Error
    func ckSave(then completion:@escaping (Result<Any, Error>)->Void) {
        var record:CKRecord
        do {
            record = try self.asCKRecord()
        } catch let error {
            completion(.failure(error))
            return
        }
        
        CKDefault.database.save(record, completionHandler: {
            (record,error) -> Void in
            
            // Got error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // else
            if let record = record {
                do {
//                    let dictinary = record.asDictionary
//                    dump(dictinary)
//                    print("RECORD ------")
//                    dump(record)
                    let object = try Self.load(from: record.asDictionary)
                    CKDefault.addToCache(record)
                    completion(.success(object))
                } catch {
                    completion(.failure(CRUDError.cannotMapRecordToObject))
                }
            }
        })
    }
    
    /**
    Read all records from a type
    - Parameters:
    - sortedBy a array of  SortDescriptors
    - returns: a (Result<Any, Error>) where Any contais a type objects array [T] in a completion handler
    */
    static func ckLoadAll(sortedBy sortKeys:[CKSortDescriptor] = [], predicate:NSPredicate = NSPredicate(value:true), then completion:@escaping (Result<Any, Error>)->Void) {
        //Preparara a query
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
                let result:[Self] = records.compactMap{
                    debugPrint($0.value(forKey: "name") ?? "--", $0.recordID.recordName)
                    let dictionary = $0.asDictionary
                    
                    return try? Self.load(from: dictionary)}
                
                guard records.count == result.count else {
                    completion(.failure(CRUDError.cannnotMapAllRecords))
                    return
                }
                CKDefault.addToCache(records)
                completion(.success(result))
            }
            
        })
        
    }
    
    static func ckLoad(with recordName: String , then completion:@escaping (Result<Any, Error>)->Void) {
        
        // Executar o fetch
        
        if let record = CKDefault.getFromCache(recordName) {
            completion(.success(record))
        }
        
        
        CKDefault.database.fetch(withRecordID: CKRecord.ID(recordName: recordName), completionHandler: { (record, error) -> Void in
            
            // Got error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            
            // else
            if let record = record {
                do {
                    let result:Self = try Self.load(from: record.asDictionary)
                    CKDefault.addToCache(record)
                    completion(.success(result))
                    return
                } catch {
                    completion(.failure(CRUDError.cannotMapRecordToObject))
                    return
                }
            } else {
                completion(.failure(CRUDError.noSurchRecord))
            }
            
        })
        
    }
    
    func ckDelete(then completion:@escaping (Result<String, Error>)->Void) {
        guard let recordName = self.recordName else { return }
        
        CKDefault.database.delete(withRecordID: CKRecord.ID(recordName: recordName), completionHandler: { (_, error) -> Void in
            
            // Got error
            if let error = error {
                completion(.failure(error))
                return
            }
            // else
            completion(.success(recordName))
            CKDefault.removeFromCache(recordName, of: Self.ckRecordType)
        })
    }
    
}

extension CloudRecord {
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName ?? self.asString ?? UUID().uuidString)
    }
}
