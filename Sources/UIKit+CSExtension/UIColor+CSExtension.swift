//
//  UIColor+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit

// MARK: - UIColor

public extension UIColor {
    
    // UIColor(hexString: 0x50E3C2, alpha: 1.0)
    public convenience init(hexString: UInt32, alpha: CGFloat = 1.0) {
        let red     = CGFloat((hexString & 0xFF0000) >> 16) / 255.0
        let green   = CGFloat((hexString & 0x00FF00) >> 8 ) / 255.0
        let blue    = CGFloat((hexString & 0x0000FF)      ) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

}

public extension CSSwift where Base: UIColor {
    
    public static var random: UIColor {
        let r = CGFloat(Double(arc4random() % 255) / 255.0)
        let g = CGFloat(Double(arc4random() % 255) / 255.0)
        let b = CGFloat(Double(arc4random() % 255) / 255.0)
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
}
