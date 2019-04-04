//
//  FileManager+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import Foundation

// MARK: - FileManager

public extension CSSwift where Base: FileManager {

    var homeDirectory: String {
        return NSHomeDirectory()
    }
    
    var tempDirectory: String {
        return NSTemporaryDirectory()
    }
    
    var documentsDirectory: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    var libraryDirectory: String {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
    }
    
    var cacheDirectory: String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
    }
}
