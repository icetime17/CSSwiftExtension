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
    public var screenSize: CGSize {
        return (UIScreen.main.currentMode?.size)!
    }
    
    public var isSize_3_5: Bool {
        return self.screenSize == CGSize(width: 640, height: 960)
    }
    
    public var isSize_4_0: Bool {
        return self.screenSize == CGSize(width: 640, height: 1136)
    }
    
    public var isSize_4_7: Bool {
        return self.screenSize == CGSize(width: 750, height: 1334)
    }
    
    public var isSize_5_5: Bool {
        return self.screenSize == CGSize(width: 1242, height: 2208)
    }
    
    public var isSize_5_5_BigMode: Bool {
        return self.screenSize == CGSize(width: 1125, height: 2001)
    }
    
    public var isIPadAir2: Bool {
        return self.screenSize == CGSize(width: 1536, height: 2048)
    }
    
    public var isIPadPro: Bool {
        return self.screenSize == CGSize(width: 2048, height: 2732)
    }
    
}
