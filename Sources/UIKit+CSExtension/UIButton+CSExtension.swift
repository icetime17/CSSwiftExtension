//
//  UIButton+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/1/4.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit


// MARK: - to avoid UIButton's multiple click operation

public extension UIButton {

    private struct CS_AssociatedKeys {
        static var acceptEventInterval  = "cs_acceptEventInterval"
        static var waitingTime          = "cs_waitingTime"
    }

    // timeInterval for UIButton to be clicked again
    // default to be 0.0s
    public var cs_acceptEventInterval: TimeInterval {
        get {
            if let acceptEventInterval = objc_getAssociatedObject(self, &CS_AssociatedKeys.acceptEventInterval) as? TimeInterval {
                return acceptEventInterval
            }
            return 0.0
        }
        
        set {
            assert(newValue > 0, "cs_acceptEventInterval should be valid")
            
            cs_methodSwizzling()
            
            objc_setAssociatedObject(self,
                                     &CS_AssociatedKeys.acceptEventInterval,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // current waiting time
    private var cs_waitingTime: TimeInterval {
        get {
            if let waitingTime = objc_getAssociatedObject(self, &CS_AssociatedKeys.waitingTime) as? TimeInterval {
                return waitingTime
            }
            return 0.0
        }
        
        set {
            objc_setAssociatedObject(self,
                                     &CS_AssociatedKeys.waitingTime,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private func cs_methodSwizzling() {
        let before: Method  = class_getInstanceMethod(self.classForCoder, #selector(self.sendAction(_:to:for:)))
        let after: Method   = class_getInstanceMethod(self.classForCoder, #selector(self.cs_sendAction(_:to:for:)))
        method_exchangeImplementations(before, after)
    }
    
    @objc private func cs_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        if Date().timeIntervalSince1970 - cs_waitingTime < cs_acceptEventInterval {
            return
        }
        
        cs_waitingTime = Date().timeIntervalSince1970
        
        cs_sendAction(action, to: target, for: event)
    }
    
}


// MARK: - set backgroundColor

public extension CSSwift where Base: UIButton {
    
    public func setBackgroundColor(_ color: UIColor?, for state: UIControlState) {
        let image = UIImage(pureColor: color!, targetSize: base.frame.size)
        base.setBackgroundImage(image, for: state)
    }
    
}

