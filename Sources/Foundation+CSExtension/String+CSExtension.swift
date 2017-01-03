//
//  String+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import Foundation

public extension String {

    public var cs_length: Int {
        return characters.count
    }

}

public extension String {
    
    // cs_trim: trim the \n and blank of leading and trailing
    public func cs_trim() -> String? {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    // cs_intValue: return Int value of String
    public func cs_intValue() -> Int? {
        let scanner = Scanner(string: self)
        scanner.scanUpToCharacters(from: CharacterSet.decimalDigits, into: nil)
        var intValue = 0
        if scanner.scanInt(&intValue) {
            return intValue
        }
        return nil
    }
    
    // cs_stringValue: return String value of String
    public func cs_stringValue() -> String? {
        let scanner = Scanner(string: self)
        var s: NSString? = ""
        if scanner.scanString(self, into: &s) {
            let stringValue = s as? String
            return stringValue
        }
        return nil
    }
    
    // cs_Data: return Data of String
    public func cs_Data() -> Data? {
        return self.data(using: String.Encoding.utf8)!
    }
    
    // cs_Date: return Date of String
    public func cs_Date() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        return dateFormatter.date(from: self)
    }
    
}
