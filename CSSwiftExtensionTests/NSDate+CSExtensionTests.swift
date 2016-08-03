//
//  NSDate+CSExtensionTests.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/8/3.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import XCTest

class NSDate_CSExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_dateFormatter() {
        let s1 = NSDate().cs_stringFromDate(nil)
        print(s1)
        let s2 = NSDate().cs_stringFromDate("yyyy-MM-dd")
        print(s2)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
