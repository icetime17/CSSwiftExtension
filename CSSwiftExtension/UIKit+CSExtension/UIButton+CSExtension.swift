//
//  UIButton+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

// MARK: - UIButton backgroundColor

public extension UIButton {

    private struct cs_backgroundColor {
        static var keyBackgroundColors              = "cs_keyBackgroundColors"
        
        static var keyBackgroundColor_Normal        = "cs_keyBackgroundColor_Normal"
        static var keyBackgroundColor_Highlighted   = "cs_keyBackgroundColor_Highlighted"
    }
    
    var cs_dictBackgroundColors: Dictionary<String, UIColor>! {
        get {
            if let dictBackgroundColors = objc_getAssociatedObject(self, &cs_backgroundColor.keyBackgroundColors) {
                return dictBackgroundColors as! Dictionary<String, UIColor>
            }
            
            return nil
        }
        
        set {
            objc_setAssociatedObject(self, &cs_backgroundColor.keyBackgroundColors, newValue as Dictionary<String, UIColor>, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func cs_setBackgroundColor(color: UIColor, forState: UIControlState) {
        if self.cs_dictBackgroundColors == nil {
            self.cs_dictBackgroundColors = Dictionary<String, UIColor>()
        }
        
        if let key = self.cs_stringForUIControlState(forState) {
            self.cs_dictBackgroundColors[key] = color
        }
    }
    
    private func cs_stringForUIControlState(state: UIControlState) -> String! {
        var cs_string = ""
        
        switch state {
        case UIControlState.Normal:
            cs_string = cs_backgroundColor.keyBackgroundColor_Normal
        case UIControlState.Highlighted:
            cs_string = cs_backgroundColor.keyBackgroundColor_Highlighted
        default:
            cs_string = cs_backgroundColor.keyBackgroundColor_Normal
        }
        
        return cs_string
    }
    
    override var highlighted: Bool {
        get {
            return super.highlighted
        }
        
        set {
            if self.cs_dictBackgroundColors == nil {
                return
            }
            
            if newValue {
                if let key = self.cs_stringForUIControlState(.Highlighted) {
                    self.backgroundColor = self.cs_dictBackgroundColors[key]! 
                }
            } else {
                if let key = self.cs_stringForUIControlState(.Normal) {
                    self.backgroundColor = self.cs_dictBackgroundColors[key]!
                }
            }
        }
    }
    
}

// MARK: - UIButton multi click issue

public extension UIButton {
    
    private struct cs_associatedKeys {
    
        static var accpetEventInterval  = "cs_acceptEventInterval"
        static var acceptEventTime      = "cs_acceptEventTime"
        
    }
    
    // 重复点击的间隔
    var cs_accpetEventInterval: NSTimeInterval {
        get {
            if let accpetEventInterval = objc_getAssociatedObject(self, &cs_associatedKeys.accpetEventInterval) as? NSTimeInterval {
                return accpetEventInterval
            }
            
            return 1.0
        }
        
        set {
            objc_setAssociatedObject(self, &cs_associatedKeys.accpetEventInterval, newValue as NSTimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var cs_acceptEventTime: NSTimeInterval {
        get {
            if let acceptEventTime = objc_getAssociatedObject(self, &cs_associatedKeys.acceptEventTime) as? NSTimeInterval {
                return acceptEventTime
            }
            
            return 1.0
        }
        
        set {
            objc_setAssociatedObject(self, &cs_associatedKeys.acceptEventTime, newValue as NSTimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
