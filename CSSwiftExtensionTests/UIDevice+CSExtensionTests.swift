//
//  UIDevice+CSExtensionTests.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/25.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import XCTest

class UIDevice_ExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_cs_screenSize() {
        print("screen size: \(UIDevice.currentDevice().cs_screenSize())")
        
        print("cs_isIPadAir2: \(UIDevice.currentDevice().cs_isIPadAir2())")
        
        print("cs_isIPadPro: \(UIDevice.currentDevice().cs_isIPadPro())")
    }
    
    func test_cs_currentLanguage() {
        print("current language: \(UIDevice.currentDevice().cs_currentLanguage())")
        
        print("is current language en: \(UIDevice.currentDevice().cs_isCurrentLanguage_en())")
    }
    
    func testPerformanceExample() {
        self.measureBlock {
        }
    }
    
}
