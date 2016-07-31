//
//  String+CSExtensionTests.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import XCTest

class String_ExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_cs_trim() {
        var s = " hi, \n hello world ".cs_trim()
        print(s)
        s = "hello world\n".cs_trim()
        print(s)
    }
    
    func test_cs_intValue() {
        print("abc123".cs_intValue()!)
        print("abc123".cs_stringValue()!)
    }
    
    func test_cs_nsdata() {
        let data = "abcdefghijklmn".cs_NSData()
        print(data)
        let s = String(data: data, encoding: NSUTF8StringEncoding)!
        print(s)
    }
    
    func testPerformanceExample() {
        self.measureBlock {
        }
    }
    
}
