//
//  NSData+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import Foundation

// MARK: - NSData

public extension NSData {
    
    func cs_jsonObjectFromNSData() -> AnyObject {
        var jsonObject: AnyObject!
        
        do {
            jsonObject = try NSJSONSerialization.JSONObjectWithData(self, options: .MutableContainers)
        } catch {
        
        }
        
        return jsonObject
    }

}