//
//  UIColor+CSExtensionTests.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import XCTest

class UIColor_ExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_colorHexString() {
        UIColor(hexString: 0x50E3C2)
        UIColor(hexString: 0x50E3C2, alpha: 1.0)
    }
    
    func testPerformanceExample() {
        self.measureBlock {
        }
    }
    
}
