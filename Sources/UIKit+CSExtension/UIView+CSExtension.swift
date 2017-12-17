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
    // when View does not care the UIViewControler it belongs to.
    public var currentViewController: UIViewController {
        var responder: UIResponder = base.next!
        while !responder.isKind(of: UIWindow.classForCoder()) {
            if responder.isKind(of: UIViewController.classForCoder()) {
                break
            }
            responder = responder.next!
        }
        return responder as! UIViewController
    }
    
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
    
    // add corner radius, may have `off-screen render` problem.
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

// MARK: - Animation
public extension CSSwift where Base: UIView {
    public func popAnimation(duration: TimeInterval = 0.5, completion: CS_ClosureWithBool? = nil) {
        base.alpha = 0
        base.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: .layoutSubviews,
                       animations: {
                        self.base.alpha = 1
                        self.base.transform = .identity
                       },
                       completion: completion)
    }
    
    public func raiseAnimation(duration: TimeInterval = 0.5, completion: CS_ClosureWithBool? = nil) {
        let offsetY = CS_ScreenHeight - base.frame.minY
        base.transform = CGAffineTransform(translationX: 0, y: offsetY)
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: .layoutSubviews,
                       animations: {
                        self.base.transform = .identity
                       },
                       completion: completion)
    }
    
    public func dropAnimation(duration: TimeInterval = 0.5, completion: CS_ClosureWithBool? = nil) {
        let offsetY = base.frame.maxY
        base.transform = CGAffineTransform(translationX: 0, y: -offsetY)
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: .layoutSubviews,
                       animations: {
                        self.base.transform = .identity
                       },
                       completion: completion)
    }
    
    public func breathAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.repeatCount = MAXFLOAT
        animation.values = [1, 0.9, 1]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = 1.0
        base.layer.add(animation, forKey: nil)
    }
    
    public func hideAnimation(duration: TimeInterval = 3.0, completion: CS_ClosureWithBool? = nil) {
        base.alpha = 1.0
        UIView.animate(withDuration: duration, animations: { 
            self.base.alpha = 0.0
        }, completion: completion)
    }
    
}

/*
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
*/

