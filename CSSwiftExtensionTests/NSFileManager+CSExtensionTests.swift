//
//  NSFileManager+CSExtensionTests.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/25.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import XCTest

class NSFileManager_ExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_cs_homeDirectory() {
        print(NSFileManager.defaultManager().cs_homeDirectory())
    }
    
    func test_cs_tempDirectory() {
        print(NSFileManager.defaultManager().cs_tempDirectory())
    }
    
    func test_cs_documentsDirectory() {
        print(NSFileManager.defaultManager().cs_documentsDirectory())
    }
    
    func test_cs_libraryDirectory() {
        print(NSFileManager.defaultManager().cs_libraryDirectory())
    }
    
    func test_cs_cacheDirectory() {
        print(NSFileManager.defaultManager().cs_cacheDirectory())
    }
    
    func testPerformanceExample() {
        self.measureBlock {
        }
    }
    
}
