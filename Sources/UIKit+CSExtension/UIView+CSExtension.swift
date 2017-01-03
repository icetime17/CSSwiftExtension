//
//  UIView+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit

// MARK: - UIView frame Related

public extension UIView {

    public var cs_left: CGFloat {
        get {
            return frame.minX
        }
        
        set(newValue) {
            frame.origin.x = newValue
        }
    }
    
    public var cs_right: CGFloat {
        get {
            return frame.maxX
        }
        
        set(newValue) {
            frame.origin.x = newValue - frame.width
        }
    }
    
    public var cs_top: CGFloat {
        get {
            return frame.minY
        }
        
        set(newValue) {
            frame.origin.y = newValue
        }
    }
    
    public var cs_bottom: CGFloat {
        get {
            return frame.maxY
        }
        
        set(newValue) {
            frame.origin.y = newValue - frame.height
        }
    }
    
    public var cs_width: CGFloat {
        get {
            return frame.width
        }
        
        set(newValue) {
            frame.size.width = newValue
        }
    }
    
    public var cs_height: CGFloat {
        get {
            return frame.height
        }
        
        set(newValue) {
            frame.size.height = newValue
        }
    }
    
}


// MARK: - snapShot

public extension UIView {
    
    public func cs_snapShot() -> UIImage {
        UIGraphicsBeginImageContext(self.bounds.size)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let snapShot: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return snapShot
    }
    
}
