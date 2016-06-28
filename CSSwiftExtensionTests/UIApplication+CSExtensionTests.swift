//
//  UIApplication+CSExtensionTests.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/25.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import XCTest

class UIApplication_ExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_cs_appVersion() {
        print("appVersion: \(UIApplication.sharedApplication().cs_appVersion())")
    }
    
    func test_cs_isRunningAppVersionReleased() {
        let isReleased = UIApplication.sharedApplication().cs_isRunningAppVersionReleased("1096082348")
        print("isReleased: \(isReleased)")
    }
    
    func test_cs_appVersionInAppStore() {
        print("appVersion in AppStore: \(UIApplication.sharedApplication().cs_appVersionInAppStore("1096082348"))")
    }
    
    func test_cs_snapShot() {
//        UIApplication.sharedApplication().cs_snapShot(UIApplication.sharedApplication().cs_currentViewController().view)
    }
    
    func testPerformanceExample() {
        self.measureBlock {
        }
    }
    
}
