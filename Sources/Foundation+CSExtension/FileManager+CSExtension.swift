//
//  FileManager+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import Foundation

// MARK: - FileManager

public extension FileManager {

    public var cs_homeDirectory: String {
        return NSHomeDirectory()
    }
    
    public var cs_tempDirectory: String {
        return NSTemporaryDirectory()
    }
    
    public var cs_documentsDirectory: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    public var cs_libraryDirectory: String {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
    }
    
    public var cs_cacheDirectory: String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
    }
}
