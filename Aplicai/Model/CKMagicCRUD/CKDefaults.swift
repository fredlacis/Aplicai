//
//  CKDefaults.swift
//  ClodKitMagic
//
//  Created by Ricardo Venieris on 28/07/20.
//  Copyright © 2020 Ricardo Venieris. All rights reserved.
//

import CloudKit


class CKDefault {
	
	struct CacheItem {
		let record: CKRecord
		let addedAt:Date
	}
	
	/**
	The default database
	By dafault get the CKContainer.default().publicCloudDatabase value.
	Can be resseted to another value
	*/
	static var database:CKDatabase  = {
//		print(CKContainer.default().containerIdentifier)
//		return CKContainer.default().publicCloudDatabase
		return CKContainer(identifier: "iCloud.com.timeGorgona.Aplicai").publicCloudDatabase
	}()
	
    static var container:CKContainer = {
        return CKContainer(identifier: "iCloud.com.timeGorgona.Aplicai")
    }()
	
	/// Cache inplementationn
	private static var cache:[String:CacheItem] = [:]
	
				/// Time in seconds for cache expiration
	private static var cacheExpirationTime:TimeInterval = 30
	
	static func addToCache(_ record:CKRecord) {
		typeIsCacheable[record.recordType] = typeIsCacheable[record.recordType] ?? true
		guard typeIsCacheable[record.recordType]! else {return}
		
		Self.cache[record.recordID.recordName] = CacheItem(record: record, addedAt: Date())
	}

	static func removeFromCache(_ recordName:String, of recordType: CKRecord.RecordType) {
		Self.cache[recordName] = nil
	}
	
	static func addToCache(_ records:[CKRecord]) {
		let _ = records.map { Self.addToCache($0) }
	}

					/// Manage if Type is Cacheable
	private static var typeIsCacheable:[String:Bool] = [:]

	static func get<T>(isCacheable type:T.Type)->Bool {
		return typeIsCacheable[getRecordTypeFor(type:type)] ?? true
	}
	
	static func set<T>(type:T.Type, isCacheable:Bool) {
		typeIsCacheable[getRecordTypeFor(type:type)] = isCacheable
	}
	
	static func getFromCache(_ recordName: String, of recordType: CKRecord.RecordType)->CacheItem? {
		return Self.cache[recordName]
	}
	
	static func getFromCache<T:CloudRecord>(all: T.Type)->[T]? {
		return Self.cache.filter {$0.value.record.recordType == T.ckRecordType}
			.compactMap{try? T.load(from: $0.value.record.asDictionary)}
		
	}
	
	/// Naming Types to RecordType implementation
	private static var typeRecordName:[String:String] = [:]
	
	static func getRecordTypeFor<T:CloudRecord>(_ object:T)->String {
		return Self.getRecordTypeFor(type: T.Type.self)
	}

	static func getRecordTypeFor<T>(type:T.Type)->String {
		let name = String(describing: type)
		return typeRecordName[name] ?? name
	}

	static func setRecordTypeFor<T:CloudRecord>(_ object:T, recordName:String) {
		Self.setRecordTypeFor(type: T.Type.self, recordName: recordName)
	}

	static func setRecordTypeFor<T>(type:T.Type, recordName:String) {
		let name = String(describing: type)
		typeRecordName[name] = recordName
	}

}
