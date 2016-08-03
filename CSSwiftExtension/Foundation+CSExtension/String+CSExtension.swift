//
//  String+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import Foundation

// MARK: - String

public extension String {
    
    // cs_trim: trim the \n and blank of leading and trailing
    func cs_trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    // cs_intValue: return Int value of String
    func cs_intValue() -> Int? {
        let scanner = NSScanner(string: self)
        scanner.scanUpToCharactersFromSet(NSCharacterSet.decimalDigitCharacterSet(), intoString: nil)
        var intValue = 0
        if scanner.scanInteger(&intValue) {
            return intValue
        }
        return nil
    }
    
    // cs_stringValue: return String value of String
    func cs_stringValue() -> String? {
        let scanner = NSScanner(string: self)
        var s: NSString? = ""
        if scanner.scanString(self, intoString: &s) {
            let stringValue = s as? String
            return stringValue
        }
        return nil
    }
    
    // cs_NSData: return NSData of String
    func cs_NSData() -> NSData {
        return self.dataUsingEncoding(NSUTF8StringEncoding)!
    }
    
    // cs_NSDate: return NSDate of String
    func cs_NSDate() -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        return dateFormatter.dateFromString(self)!
    }
    
}