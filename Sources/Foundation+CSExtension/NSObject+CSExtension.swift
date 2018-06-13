//
//  NSObject+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/3/6.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import Foundation

public extension CSSwift where Base: NSObject {

    public var ivars: [String] {
        var ret = [String]()
        
        var count: u_int = 0
        if let ivars = class_copyIvarList(base.classForCoder, &count) {
            for i in 0..<Int(count) {
                let ivar = ivars[i]
                if let cString = ivar_getName(ivar) {
                    ret.append(String(cString: cString as UnsafePointer<CChar>))
                }
            }
            free(ivars)
        }
        
        return ret
    }

    public var properties: [String] {
        var ret = [String]()
        
        var count: u_int = 0
        if let properties = class_copyPropertyList(base.classForCoder, &count) {
            for i in 0..<Int(count) {
                let property = properties[i]
                let cString = property_getName(property)
                ret.append(String(cString: cString as UnsafePointer<CChar>))
            }
            free(properties)
        }
        
        return ret
    }
    
    public var methods: [String] {
        var ret = [String]()
        
        var count: u_int = 0
        if let methods = class_copyMethodList(base.classForCoder, &count) {
            for i in 0..<Int(count) {
                let method = methods[i]
                let selector = method_getName(method)
                let cString = sel_getName(selector)
                ret.append(String(cString: cString as UnsafePointer<CChar>))
            }
            free(methods)
        }
        
        return ret
    }
    
    public var protocols: [String] {
        var ret = [String]()
        
        var count: u_int = 0
        if let protocols = class_copyProtocolList(base.classForCoder, &count) {
            for i in 0..<Int(count) {
                let proto = protocols[i]
                let cString = protocol_getName(proto)
                ret.append(String(cString: cString as UnsafePointer<CChar>))
            }
            // No need to free protocols because it's AutoreleasingUnsafeMutablePointer<Protocol?>!
        }
        
        return ret
    }
    
}
