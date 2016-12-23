//
//  Date+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import Foundation

// MARK: - Date

public extension Date {
    
    // string from Date
    public func cs_stringFromDate(_ dateFormat: String?) -> String {
        let dateFormatter = DateFormatter()
        if dateFormat != nil {
            dateFormatter.dateFormat = dateFormat
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        }
        
        return dateFormatter.string(from: self)
    }
    
}
