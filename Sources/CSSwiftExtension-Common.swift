//
//  CSSwiftExtension-Common.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/2/6.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import Foundation

public func cs_print(_ c: Any, file: String = #file, method: String = #function , line: Int = #line) {
    debugPrint(">>> \(file.components(separatedBy: "/").last!)-\(method)-\(line): \(c)")
}
