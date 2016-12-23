//
//  String+CSExtensionTests.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/23.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import XCTest

class String_CSExtensionTests: XCTestCase {
    
    let string = " hello 17, this is my city "
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let a = string.cs_trim()
        let b = string.cs_intValue()
        let c = string.cs_stringValue()
        let d = string.cs_Data()
        let e = "2017-01-01 01:01:01".cs_Date()
        
        print("done")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
