//
//  UIScreen+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/1/3.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit


// MARK: - UIScreen related

public extension CSSwift where Base: UIScreen {
    
    
    //////////////////////////////////////////////////
    
    
    // Screen Related
    var screenSize: CGSize {
        return (UIScreen.main.currentMode?.size)!
    }
    
    var isSize_3_5: Bool {
        return self.screenSize == CGSize(width: 640, height: 960)
    }
    
    var isSize_4_0: Bool {
        return self.screenSize == CGSize(width: 640, height: 1136)
    }
    
    var isSize_4_7: Bool {
        return self.screenSize == CGSize(width: 750, height: 1334)
    }
    
    var isSize_5_5: Bool {
        return self.screenSize == CGSize(width: 1242, height: 2208)
    }
    
    var isSize_5_5_BigMode: Bool {
        return self.screenSize == CGSize(width: 1125, height: 2001)
    }
    
    var isIPadAir2: Bool {
        return self.screenSize == CGSize(width: 1536, height: 2048)
    }
    
    var isIPadPro: Bool {
        return self.screenSize == CGSize(width: 2048, height: 2732)
    }
    
}
