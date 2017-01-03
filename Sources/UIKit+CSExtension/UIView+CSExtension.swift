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
        set {
            frame.origin.x = newValue
        }
    }
    
    public var cs_right: CGFloat {
        get {
            return frame.maxX
        }
        set {
            frame.origin.x = newValue - frame.width
        }
    }
    
    public var cs_top: CGFloat {
        get {
            return frame.minY
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    public var cs_bottom: CGFloat {
        get {
            return frame.maxY
        }
        set {
            frame.origin.y = newValue - frame.height
        }
    }
    
    public var cs_width: CGFloat {
        get {
            return frame.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    public var cs_height: CGFloat {
        get {
            return frame.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    public var cs_size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
    
}


// MARK: - snapShot

public extension UIView {
    
    public var cs_snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
