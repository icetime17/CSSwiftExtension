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

    // length
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
            let stringValue = s as String?
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

public extension String {
    
    // reverse
    public var cs_reversed: String {
        return String(characters.reversed())
    }
    
    // index of subString
    public func cs_indexOfSubString(_ tString: String) -> Int {
        if tString.isEmpty {
            return -1
        }
        
        let oChars = [Character](characters)
        let tChars = [Character](tString.characters)
        
        if oChars.count < tChars.count {
            return -1
        }
        
        for i in 0...(oChars.count - tChars.count) {
            if oChars[i] != tChars[0] {
                continue
            }
            
            for j in 0..<tChars.count {
                if oChars[i+j] != tChars[j] {
                    break
                }
                
                if j == tChars.count - 1 {
                    return i
                }
            }
        }
        
        return -1
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
    
    // dynamic height
    public func dts_heightOf(font: UIFont, maxSize: CGSize) -> CGFloat {
        let rect = (self as NSString).boundingRect(with: maxSize,
                                                   options: .usesLineFragmentOrigin,
                                                   attributes: [NSFontAttributeName: font],
                                                   context: nil)
        return rect.height
    }
    
    // custom font, line, kern
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

// MARK: - Version Compare
public extension String {
    
    public func cs_isEqualTo(_ v: String) -> Bool {
        return self.compare(v, options: .numeric, range: nil, locale: nil) == .orderedSame
    }
    
    public func cs_isHigherThan(_ v: String) -> Bool {
        return self.compare(v, options: .numeric, range: nil, locale: nil) == .orderedDescending
    }
    
    public func cs_isEqualToOrHigherThan(_ v: String) -> Bool {
        return self.compare(v, options: .numeric, range: nil, locale: nil) != .orderedAscending
    }
    
    public func cs_isLowerThan(_ v: String) -> Bool {
        return self.compare(v, options: .numeric, range: nil, locale: nil) == .orderedAscending
    }
    
    public func cs_isEqualToOrLowerThan(_ v: String) -> Bool {
        return self.compare(v, options: .numeric, range: nil, locale: nil) != .orderedDescending
    }
    
}
