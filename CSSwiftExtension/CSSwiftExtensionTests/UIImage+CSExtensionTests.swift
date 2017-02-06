//
//  UIImage+CSExtensionTests.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/23.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import XCTest

class UIImage_CSExtensionTests: XCTestCase {
    
    let image = UIImage(named: "Model.jpg")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExtensions() {
        cs_print("original image size : \(image?.size)")
        
        let a = image?.cs_imageMirrored
        let b = image?.cs_imageCropped(bounds: CGRect(x: 0, y: 0, width: 200, height: 200))
        let c = image?.cs_imageWithNormalOrientation
        let d = image?.cs_imageRotatedByDegrees(degrees: 90)
        let e = image?.cs_imageWithCornerRadius(cornerRadius: 100)
        let f = image?.cs_imageScaledToSize(targetSize: CGSize(width: 300, height: 300), withOriginalRatio: true)
        let g = image?.cs_wechatShareThumbnail
        
        let h = image?.cs_grayScale
        
        cs_print("done")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
