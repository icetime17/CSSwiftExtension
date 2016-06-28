//
//  NSFileManager+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import Foundation

// MARK: - NSFileManager

public extension NSFileManager {

    func cs_homeDirectory() -> String {
        return NSHomeDirectory()
    }
    
    func cs_tempDirectory() -> String {
        return NSTemporaryDirectory()
    }
    
    func cs_documentsDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    }
    
    func cs_libraryDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)[0]
    }
    
    func cs_cacheDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0]
    }
}