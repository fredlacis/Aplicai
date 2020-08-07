//
//  CodableExtension.swift
//  JsonClassSaver
//
//  Created by Ricardo Venieris on 30/11/18.
//  Copyright © 2018 LES.PUC-RIO. All rights reserved.
//

import CloudKit

enum FileManageError:Error {
	case canNotSaveInFile
	case canNotReadFile
	case canNotConvertData
	case canNotDecodeData
}

extension Error {
	public var asString:String {
		return String(describing: self)
	}
}

extension Encodable {
	
	var asString:String? {
		return self.jsonData?.asText
	}
	
	var asDictionary:[String: Any]? {
		if let json:Data = self.jsonData
		{
			do {
				//                let jsonObject = try JSONSerialization.jsonObject(with: json, options: [])
				let jsonObject = try JSONSerialization.jsonObject(with: json, options: [JSONSerialization.ReadingOptions.allowFragments])
				
				// if jsonObject is OK
				if let dic = jsonObject as? [String: Any] {
					return dic
				}
				// else
				if let value = jsonObject as? [Any] {
					let key = String(describing: type(of:self))
					return [key:value]
				}
			} catch {
				debugPrint(error.localizedDescription)
				return nil
			}
		} // else
		return nil
	}
	
	var asArray:[Any]? {
		do {
			return try JSONSerialization.jsonObject(with: JSONEncoder().encode(self), options: []) as? [Any]
		} catch {
			debugPrint(error.localizedDescription)
		}
		return nil
	}
	
	var jsonData:Data? {
		do {
			return try JSONEncoder().encode(self)
		} catch {}
		return nil
	}
	
	func save(in file:String? = nil)throws {
		// generates URL for documentDir/file.json
		let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
		let fileName = file ?? String(describing: type(of: self))
		let url = URL(fileURLWithPath: documentDir.appendingPathComponent(fileName+".json"))
		try self.save(in: url)
	}
	
	func save(in url:URL)throws {
		
		// Try to save
		do {
			try JSONEncoder().encode(self).write(to: url)
			debugPrint("Save in", String(describing: url))
		} catch {
			debugPrint("Can not save in", String(describing: url))
			throw FileManageError.canNotSaveInFile
		}
		
	}
}

extension Decodable {
	
	mutating func load(from url:URL) throws {
				
		// Try to read
		do {
			let readedData = try Data(contentsOf: url)
			try load(from: readedData)
		} catch {
			debugPrint("Can not read from", String(describing: url))
			throw FileManageError.canNotReadFile
		}
	}
	
	
	mutating func load(from file:String? = nil) throws {
		
		// generates URL for documentDir/file.json
		let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
		let fileName = file ?? String(describing: type(of: self))
		let url = URL(fileURLWithPath: documentDir.appendingPathComponent(fileName+".json"))
		
		// Try to read
		do {
			let readedData = try Data(contentsOf: url)
			try load(from: readedData)
		} catch {
			debugPrint("Can not read from", String(describing: url))
			throw FileManageError.canNotReadFile
		}
	}
	
	mutating func load(from data:Data) throws {
		// Try to read
		do {
			let data = data.base64EncodedData()
			let readedInstance = try JSONDecoder().decode(Self.self, from: data)
			self = readedInstance
		} catch {
			debugPrint("Can not read from", String(describing: data))
			throw FileManageError.canNotConvertData
		}
	}
	
	mutating func load(fromString stringData:String) throws {
		// Try to read
		guard let data = stringData.data(using: .utf8)?.base64EncodedData() else {
			fatalError("this is not a data")
		}
		do {
			let readedInstance = try JSONDecoder().decode(Self.self, from: data)
			self = readedInstance
		} catch {
			debugPrint("Can not read from", String(describing: data))
			throw FileManageError.canNotConvertData
		}
	}
	
	
	// MARK: Decoder Dicionario
	mutating func load(from dictionary:[String:Any]) throws {
		do {
			guard let data:Data = (dictionary[String(describing: self)] as? [Any])?.asData ??
				dictionary.asData else {
					debugPrint("Can not convert from dictionary to", String(describing: type(of: self)))
					throw FileManageError.canNotConvertData
			}
			try load(from: data)
		} catch {
			debugPrint("Can not convert from dictionary to", String(describing: type(of: self)))
			throw FileManageError.canNotConvertData
		}
	}
	
	mutating func load(from array:[Any]) throws {
		
		do {
			guard let data = array.asData else {
				debugPrint("Can not convert from array to", String(describing: type(of: self)))
				throw FileManageError.canNotConvertData
			}
			try load(from: data)
		} catch {
			debugPrint("Can not convert from array to", String(describing: type(of: self)))
			throw FileManageError.canNotConvertData
		}

	}
	
}

/// Static Loads
extension Decodable {
	
	static private func url(from file:String? = nil)->URL {
		// generates URL for documentDir/file.json
		if let fileName = file {
			if fileName.lowercased().hasPrefix("http") {
				return URL(string: fileName) ?? URL(fileURLWithPath: fileName)
			} //else
			return URL(fileURLWithPath: fileName)
		} else {
			let fileName = String(describing: self)
			let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
			return URL(fileURLWithPath: documentDir.appendingPathComponent(fileName+".json"))
		}
	}
	
	static func load(from file:String? = nil)throws ->Self {
		// Try to read
		do {
			let data = try Data(contentsOf: Self.url(from: file))
			return try load(from: data)
		} catch {
			debugPrint("Can not read from", file ?? String(describing: self))
			throw FileManageError.canNotReadFile
		}
	}
	
	static func load(from data:Data)throws ->Self {
		// Try to read
		do {
			return try JSONDecoder().decode(Self.self, from: data)
		} catch {
			debugPrint("Can not read from", String(describing: data))
			throw FileManageError.canNotConvertData
		}
	}
	
	static func load(fromString stringData:String)throws ->Self{
		// Try to read
		guard let data = stringData.data(using: .utf8) else {
			fatalError("this is not a data")
		}
		do {
			return try load(from: data)
		} catch {
			debugPrint("Can not read from", String(describing: data))
			throw FileManageError.canNotConvertData
		}
	}
	
	static func load(from dictionary:[String:Any])throws ->Self{
		do {
			guard let data:Data = (dictionary[String(describing: self)] as? [Any])?.asData ??
								   dictionary.asData else {
					debugPrint("Can not convert from dictionary to", String(describing: type(of: self)))
					throw FileManageError.canNotConvertData
			}
			return try Self.load(from: data)
		} catch {
			debugPrint("Can not convert from dictionary to", String(describing: type(of: self)))
			throw FileManageError.canNotConvertData
		}
	}
	
	static func load(from array:[Any])throws ->Self{
		
		do {
			guard let data = array.asData else {
				debugPrint("Can not convert from array to", String(describing: type(of: self)))
				throw FileManageError.canNotConvertData
			}
			return try Self.load(from: data)
		} catch {
			debugPrint("Can not convert from array to", String(describing: type(of: self)))
			throw FileManageError.canNotConvertData
		}
	}
	
}


/// Type Extensions
extension Data {
	
	public var asText:String {
		return String(data: self, encoding: .utf8) ?? #""ERROR": "cannot decode into String"""#
	}
	
	public var asDictionary:[AnyHashable:Codable] {
		let data = self.base64EncodedData()
		if let dictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Codable] {
			return dictionary
		}
		// else
		
		if let array = self.asArray as? Codable {
			return ["Array":array]
		}
		// else
		return ["ERROR":"cannot decode into dictionary"]
	}
	
	public var asArray:[Codable]? {
		let data = self.base64EncodedData()
		return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Codable]
	}
	
	public func convert<T>(to:T.Type) throws ->T where T:Codable {
		// Try to convert
		do {
			return try JSONDecoder().decode(T.self, from: self)
			
		} catch {
			debugPrint("cannot convert this: \(String(describing: self.asString))")
			throw FileManageError.canNotDecodeData
		}
	}
	
	/// Saves data in a file in default.temporaryDirectory, returning URL
	func saveInTemp()throws->URL {
		let tmpDirURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString+".data")
		try self.write(to: tmpDirURL)
		return tmpDirURL
	}
		
}

extension URL {
	var contentAsData:Data? {
		return try? Data(contentsOf: self)
	}
}


extension Array {
	var asData:Data? {
		guard let array = CertifiedCodableData(["Array":self]).dictionary["Array"] else {return nil}
		return try? JSONSerialization.data(withJSONObject: array, options: [])
	}
}

extension Dictionary where Key == String {
	var asData:Data? {
		let dic = CertifiedCodableData(self).dictionary
		return try? JSONSerialization.data(withJSONObject: dic, options: [])
	}
	
}

private struct CertifiedCodableData:Codable {
	private var string:[String:String] = [:]
	private var number:[String:Double] = [:]
	private var date:[String:Date] = [:]
	private var data:[String:Data] = [:]
	private var custom:[String:CertifiedCodableData] = [:]

	private var stringArray:[String:[String]] = [:]
	private var numberArray:[String:[Double]] = [:]
	private var dateArray:[String:[Date]] = [:]
	private var dataArray:[String:[Data]] = [:]
	private var customArray:[String:[CertifiedCodableData]] = [:]
	
	var dictionary:[String:Any] {
		var dic:[String:Any] = [:]
		for item in self.asDictionary ?? [:] {
			
			switch item.key {
				case "string":
					(item.value as? [String:String])?.forEach{dic[$0.key] = $0.value}
				case "number":
					(item.value as? [String:Double])?.forEach{dic[$0.key] = $0.value}
				case "date":
					(item.value as? [String:Date])?.forEach{dic[$0.key] = $0.value}
				case "data":
					(item.value as? [String:Data])?.forEach{dic[$0.key] = $0.value}
				case "custom":
					(item.value as? [String:CertifiedCodableData])?.forEach{dic[$0.key] = $0.value.dictionary}
				case "stringArray":
					(item.value as? [String:[String]])?.forEach{dic[$0.key] = $0.value}
				case "numberArray":
					(item.value as? [String:[Double]])?.forEach{dic[$0.key] = $0.value}
				case "dateArray":
					(item.value as? [String:[Date]])?.forEach{dic[$0.key] = $0.value}
				case "dataArray":
					(item.value as? [String:[Data]])?.forEach{dic[$0.key] = $0.value}
				case "customArray":
					(item.value as? [String:[CertifiedCodableData]])?.forEach{dic[$0.key] = $0.value.map {$0.dictionary}}
				default:
					fatalError("Error in Data Conversion \(item.key) is unknown")

			}
		}
		return dic
	}

	
	init(_ originalData:[String:Any]) {
		for item in originalData {
			
				 if let dado = item.value as? String 				 { string	  [item.key] = dado}
			else if let dado = item.value as? Double 				 { number	  [item.key] = dado}
			else if let dado = item.value as? Date   				 { date		  [item.key] = dado}
			else if let dado = item.value as? Data   				 { data	      [item.key] = dado}
			else if let dado = item.value as? CertifiedCodableData   { custom	  [item.key] = dado}
					
			else if let dado = item.value as? [String 			   ] { stringArray[item.key] = dado}
			else if let dado = item.value as? [Double 			   ] { numberArray[item.key] = dado}
			else if let dado = item.value as? [Date   			   ] { dateArray  [item.key] = dado}
			else if let dado = item.value as? [Data   			   ] { dataArray  [item.key] = dado}
			else if let dado = item.value as? [CertifiedCodableData] { customArray[item.key] = dado}

			else if let dado = item.value as? CKAsset { data[item.key] = dado.fileURL?.contentAsData}
			else if let dado = item.value as? [CKAsset] {
					dataArray[item.key] = dado.compactMap{$0.fileURL?.contentAsData}
			}
			else {
					debugPrint("Unknown Type in originalData: \(item.key) = \(item.value)")
			}

		}
	}
	
}
