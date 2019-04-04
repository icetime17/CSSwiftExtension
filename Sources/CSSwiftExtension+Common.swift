//
//  CSSwiftExtension+Common.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/2/6.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit


public let CS_ScreenSize    = UIScreen.main.bounds.size
public let CS_ScreenWidth   = CS_ScreenSize.width
public let CS_ScreenHeight  = CS_ScreenSize.height


public typealias CS_JSONDictionary = [String: Any]


public typealias CS_ClosureWithNone         = () -> Void
public typealias CS_ClosureWithInt          = (_ value: Int) -> Void
public typealias CS_ClosureWithBool         = (_ finished: Bool) -> Void
public typealias CS_ClosureWithString       = (_ str: String) -> Void
public typealias CS_ClosureWithArray        = (_ array: Array<Any>) -> Void
public typealias CS_ClosureWithDictionary   = (_ dict: CS_JSONDictionary) -> Void
public typealias CS_ClosureWithData         = (_ data: Data) -> Void
public typealias CS_ClosureWithImage        = (_ image: UIImage) -> Void


public func CS_Print(_ c: Any, file: String = #file, method: String = #function , line: Int = #line) {
    debugPrint(">>> \(file.components(separatedBy: "/").last!)-\(method)-\(line): \(c)")
}
