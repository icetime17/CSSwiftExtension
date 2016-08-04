//
//  UIImage+CSExtensionTests.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/25.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import XCTest

class UIImage_ExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_imageFromURLString() {
        let g: UIImage = UIImage(urlString: "http://h.hiphotos.baidu.com/image/pic/item/f31fbe096b63f624ec82b20a8544ebf81b4ca3d8.jpg")
        print("set breakpoint to check the UIImage")
        
        let filePath1 = NSFileManager.defaultManager().cs_tempDirectory().stringByAppendingString("image.png")
        let filePath2 = NSFileManager.defaultManager().cs_tempDirectory().stringByAppendingString("image.jpeg")
        let successed1 = g.cs_saveImageToFile(filePath1, compressionFactor: 1.0)
        let successed2 = g.cs_saveImageToFile(filePath2, compressionFactor: 1.0)
        
        let h = g.cs_imageRotatedByDegrees(-45)
        let i = g.cs_imageRotatedByDegrees(45)
        let j = g.cs_imageWithCornerRadius(200)
        let k = g.cs_imageWithCornerRadius(g.size.height)
        
        let pureColor = UIColor(hexString: 0x50E3C2, alpha: 0.5)
        let l = UIImage(pureColor: pureColor, size: CGSizeMake(200, 200))
        
        print(successed1)
        
        let m = g.cs_imageMirrored()
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
