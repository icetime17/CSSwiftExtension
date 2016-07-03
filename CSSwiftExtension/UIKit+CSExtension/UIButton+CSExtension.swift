//
//  UIButton+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

// MARK: - UIButton Related

public extension UIButton {
    
    private struct cs_associatedKeys {
    
        static var accpetEventInterval  = "cs_acceptEventInterval"
        static var acceptEventTime      = "cs_acceptEventTime"
        
    }
    
    // 重复点击的间隔
    var cs_accpetEventInterval: NSTimeInterval {
        set {
            objc_setAssociatedObject(self, &cs_associatedKeys.accpetEventInterval, newValue as NSTimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            if let accpetEventInterval = objc_getAssociatedObject(self, &cs_associatedKeys.accpetEventInterval) as? NSTimeInterval {
                return accpetEventInterval
            }
            
            return 1.0
        }
    }
    
    var cs_acceptEventTime: NSTimeInterval {
        set {
            objc_setAssociatedObject(self, &cs_associatedKeys.acceptEventTime, newValue as NSTimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            if let acceptEventTime = objc_getAssociatedObject(self, &cs_associatedKeys.acceptEventTime) as? NSTimeInterval {
                return acceptEventTime
            }
            
            return 1.0
        }
    }
    
    override public class func initialize() {
        let before: Method = class_getInstanceMethod(self, #selector(UIButton.sendAction(_:to:forEvent:)))
        let after: Method  = class_getInstanceMethod(self, #selector(UIButton.cs_sendAction(_:to:forEvent:)))
        
        method_exchangeImplementations(before, after)
    }

    func cs_sendAction(action: Selector, to target: AnyObject?, forEvent event: UIEvent?) {
        if NSDate().timeIntervalSince1970 - self.cs_acceptEventTime < self.cs_accpetEventInterval {
            return
        }
        
        if self.cs_accpetEventInterval > 0 {
            self.cs_acceptEventTime = NSDate().timeIntervalSince1970
        }
        
        self.cs_sendAction(action, to: target, forEvent: event)
    }
    
    
}