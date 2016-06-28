//
//  UIView+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

// MARK: - UIView frame Related

public extension UIView {

    var cs_left : CGFloat {
        get {
            return CGRectGetMinX(self.frame)
        }
        
        set(newValue) {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var cs_right : CGFloat {
        get {
            return CGRectGetMaxX(self.frame)
        }
        
        set(newValue) {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
    }
    
    var cs_top : CGFloat {
        get {
            return CGRectGetMinY(self.frame)
        }
        
        set(newValue) {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var cs_bottom : CGFloat {
        get {
            return CGRectGetMaxY(self.frame)
        }
        
        set(newValue) {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }
    
    var cs_width : CGFloat {
        get {
            return CGRectGetWidth(self.frame)
        }
        
        set(newValue) {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var cs_height : CGFloat {
        get {
            return CGRectGetHeight(self.frame)
        }
        
        set(newValue) {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
}


// MARK: - snapShot

public extension UIView {
    
    func cs_snapShot() -> UIImage {
        UIGraphicsBeginImageContext(self.bounds.size)
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let snapShot: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapShot
    }
    
}