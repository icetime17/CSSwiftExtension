//
//  DispatchQueue+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/1/4.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import Foundation

public extension DispatchQueue {
    
    public class func cs_main(execute: @escaping () -> Void) {
        main.async(execute: execute)
    }
    
    public class func cs_global(execute: @escaping () -> Void) {
        global().async(execute: execute)
    }
    
    public class func cs_delay(_ time: Double, execute: @escaping () -> Void) {
        main.asyncAfter(deadline: .now() + time, execute: execute)
    }
    
}
