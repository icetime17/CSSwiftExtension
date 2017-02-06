//
//  DispatchQueue+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/1/4.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import Foundation

public extension CSSwift where Base: DispatchQueue {
    
    public static func main(execute: @escaping () -> Void) {
        Base.main.async(execute: execute)
    }
    
    public static func global(execute: @escaping () -> Void) {
        Base.global().async(execute: execute)
    }
    
    public static func delay(_ time: Double, execute: @escaping () -> Void) {
        Base.main.asyncAfter(deadline: .now() + time, execute: execute)
    }
    
}
