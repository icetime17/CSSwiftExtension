//
//  NSDate+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/8/3.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import Foundation

// MARK: - NSDate

public extension NSDate {
    
    
    func cs_stringFromDate(dateFormat: String?) -> String {
        let dateFormatter = NSDateFormatter()
        if dateFormat != nil {
            dateFormatter.dateFormat = dateFormat
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        }
        
        return dateFormatter.stringFromDate(self)
    }
    
}