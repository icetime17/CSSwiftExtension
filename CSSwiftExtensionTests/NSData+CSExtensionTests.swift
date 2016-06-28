//
//  NSData+CSExtensionTests.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/25.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import XCTest

class NSData_ExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_cs_jsonObjectFromNSData() {
        let urlString = "https://itunes.apple.com/lookup?id=1096082348"
        
        let request = NSURLRequest(URL: NSURL(string: urlString)!)
        
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request)
        { (data, response, error) in
            let jsonObject = data?.cs_jsonObjectFromNSData()
            print("jsonObject: \(jsonObject)")
        }
        dataTask.resume()
    }
    
    func testPerformanceExample() {
        self.measureBlock {
        }
    }
    
}
