//
//  String+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit
import Foundation

public extension String {

    public var cs_length: Int {
        return characters.count
    }

}

public extension String {
    
    // utf8 String
    public var cs_utf8String: String {
        return String(utf8String: cString(using: String.Encoding.utf8)!)!
    }
    
    // cs_trimmed: trim the \n and blank of leading and trailing
    public var cs_trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    // cs_intValue: return Int value of String
    public var cs_intValue: Int? {
        let scanner = Scanner(string: self)
        scanner.scanUpToCharacters(from: CharacterSet.decimalDigits, into: nil)
        var intValue = 0
        if scanner.scanInt(&intValue) {
            return intValue
        }
        return nil
    }
    
    // cs_stringValue: return String value of String
    public var cs_stringValue: String? {
        let scanner = Scanner(string: self)
        var s: NSString? = ""
        if scanner.scanString(self, into: &s) {
            let stringValue = s as? String
            return stringValue
        }
        return nil
    }
    
    // cs_Data: return Data of String
    public var cs_Data: Data? {
        return self.data(using: String.Encoding.utf8)!
    }
    
    // cs_Date: return Date of String
    public var cs_Date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        return dateFormatter.date(from: self)
    }
    
}

// MARK: - Regular expression
public extension String {
    
    public func cs_validateWithRegExp(regExp: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regExp)
        return predicate.evaluate(with: self)
    }
    
    public var cs_isEmailValidate: Bool {
        let regExp_email = "^[a-zA-Z0-9]{1,}@[a-zA-Z0-9]{1,}\\.[a-zA-Z]{2,}$"
        return cs_validateWithRegExp(regExp: regExp_email)
    }
    
    public var cs_isPhoneNumberValidate: Bool {
        let regExp_phoneNumber = "^1\\d{10}$"
        return cs_validateWithRegExp(regExp: regExp_phoneNumber)
    }
    
}

// MARK: - Method
public extension String {
    
    public func cs_attributesStringWithFont(font: UIFont, lineSpacing: CGFloat, kernSpacing: CGFloat, textAlignment: NSTextAlignment) -> NSAttributedString {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineBreakMode = .byWordWrapping
        paraStyle.alignment = textAlignment
        paraStyle.lineSpacing = lineSpacing // 行间距
        paraStyle.hyphenationFactor = 1.0
        paraStyle.firstLineHeadIndent = 0.0
        paraStyle.paragraphSpacingBefore = 0.0
        paraStyle.headIndent = 0.0
        paraStyle.tailIndent = 0.0
        
        // 字间距
        let dict = [
            NSFontAttributeName: font,
            NSParagraphStyleAttributeName: paraStyle,
            NSKernAttributeName: kernSpacing
            ] as [String : Any]
        return NSAttributedString(string: self, attributes: dict)
    }
    
}
