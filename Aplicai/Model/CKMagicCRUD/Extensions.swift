//
//  Extensions.swift
//  CloudKitExample
//
//  Created by Ricardo Venieris on 26/07/20.
//  Copyright © 2020 Ricardo Venieris. All rights reserved.
//

import CloudKit

extension CKRecord {
	var asDictionary:[String:Any] {
		var result:[String:Any] = [:]
		result["recordName"] = self.recordID.recordName
		for key in self.allKeys() {
			result[key] = self.value(forKey: key)
		}
		return result
	}
}

extension CKAsset {
	convenience init(data:Data) {
		let url = URL(fileURLWithPath: NSTemporaryDirectory().appending(UUID().uuidString+".data"))
		do {
			try data.write(to: url)
		} catch let e as NSError {
			debugPrint("Error! \(e)")
		}
		self.init(fileURL: url)
	}
	
	var data:Data? {
		return self.fileURL?.contentAsData
	}
}

extension Optional where Wrapped == String {
	var isEmpty:Bool {
		return self?.isEmpty ?? true
	}
}

extension String {
	func deleting(suffix: String) -> String {
		guard self.hasSuffix(suffix) else { return self }
		return String(self.dropLast(suffix.count))
	}
}


/**
- Description
	A String that have "⇩" as last character if it's SortDescriptor is descending
	set the descriptos as descending using (ckSort.descending)
*/
typealias CKSortDescriptor = NSString
extension NSString {
	
	/// For use of SortDescriptor
	class CK {
		private var text:String
		var  isAscending:Bool { text.last != "⇩" }
		var isDescending:Bool { text.last == "⇩" }
		var    ascending:String { return  isAscending ? text : String(text.dropLast()) }
		var   v:String { return isDescending ? text : text+"⇩" }
		var   descriptor:NSSortDescriptor { NSSortDescriptor(key: ascending, ascending:isAscending) }
		init(_ text:NSString) { self.text = String(text) }
	}
	
	
	/**
	- Description:
	Elements for use of SortDescriptors
	*/
	var ckSort:CK {CK(self)}
	
	
}

extension Array where Element == CKSortDescriptor {
	var ckSortDescriptors:[NSSortDescriptor] { self.map { $0.ckSort.descriptor }
	}
	
}

extension Date {
	/// Initializes with specific date & format default format: ( yyyy/MM/dd HH:mm )
	init(date:String, format:String? = nil) {
		self.init()
		self.set(date: date, format: format)
	}
	
	mutating func set(date:String, format:String? = nil) {
		
		let format = format ?? (date.count == 16 ? "yyyy/MM/dd HH:mm" : "yyyy/MM/dd")
		let formatter = DateFormatter()
		formatter.dateFormat = format
		guard let newDate = formatter.date(from: date) else {
			debugPrint("date \(date) in format \(format) does not results in a valid date")
			return
		}
		self = newDate
	}
}


// Global Functions


/// Check if object Type is Element or Array of Number, String & Date
func isBasicType(_ value:Any)->Bool {
	let typeDesctiption = String(describing: type(of: value))
	return typeDesctiption.contains("Int") || typeDesctiption.contains("Float") || typeDesctiption.contains("Double") || typeDesctiption.contains("String") || typeDesctiption.contains("Date")
}
