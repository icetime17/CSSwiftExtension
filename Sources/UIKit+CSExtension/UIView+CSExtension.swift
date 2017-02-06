//
//  UIView+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit

// MARK: - UIView frame Related

public extension CSSwift where Base: UIView {

    public var left: CGFloat {
        get {
            return base.frame.minX
        }
        set {
            base.frame.origin.x = newValue
        }
    }
    
    public var right: CGFloat {
        get {
            return base.frame.maxX
        }
        set {
            base.frame.origin.x = newValue - base.frame.width
        }
    }
    
    public var top: CGFloat {
        get {
            return base.frame.minY
        }
        set {
            base.frame.origin.y = newValue
        }
    }
    
    public var bottom: CGFloat {
        get {
            return base.frame.maxY
        }
        set {
            base.frame.origin.y = newValue - base.frame.height
        }
    }
    
    public var width: CGFloat {
        get {
            return base.frame.width
        }
        set {
            base.frame.size.width = newValue
        }
    }
    
    public var height: CGFloat {
        get {
            return base.frame.height
        }
        set {
            base.frame.size.height = newValue
        }
    }
    
    public var size: CGSize {
        get {
            return base.frame.size
        }
        set {
            base.frame.size = newValue
        }
    }
    
}


// MARK: -

public extension CSSwift where Base: UIView {
    
    public var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        base.layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // add corner radius
    // aView.cs.setCornerRadius(corners: [.bottomLeft, .bottomRight], radius: 20)
    public func setCornerRadius(corners: UIRectCorner = .allCorners, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: base.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        base.layer.mask = shape
    }
    
}


public extension CSSwift where Base: UIView {
    
    // init UIView from a nib file
    // let aView = AView.cs.loadFromNib("AView") as? AView
    public static func loadFromNib(_ nibName: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: nil, options: nil).first as? UIView
    }
}


// MARK: - Gesture
public extension CSSwift where Base: UIView {
    public func removeGestureRecognizers() {
        base.gestureRecognizers?.forEach(base.removeGestureRecognizer)
    }
}


// MARK: - reuse
public protocol ReusableView {
    
}

public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


// MARK: - nib
public protocol NibLoadable {
    
}

public extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
