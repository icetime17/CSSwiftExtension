//
//  UIApplication+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit

// MARK: - UIApplication

public extension CSSwift where Base: UIApplication {
    
    // cs.appDelegate: current AppDelegate
    public var appDelegate: UIApplicationDelegate {
        return UIApplication.shared.delegate!
    }
    
    // cs.currentViewController: current UIViewController
    public var currentViewController: UIViewController {
        let window = self.appDelegate.window
        var viewController = window!!.rootViewController
        
        while ((viewController?.presentedViewController) != nil) {
            viewController = viewController?.presentedViewController
            
            if ((viewController?.isKind(of: UINavigationController.classForCoder())) == true) {
                viewController = (viewController as! UINavigationController).visibleViewController
            } else if ((viewController?.isKind(of: UITabBarController.classForCoder())) == true) {
                viewController = (viewController as! UITabBarController).selectedViewController
            }
        }
        
        return viewController!
    }
    
}


// MARK: - App Version Related

public extension CSSwift where Base: UIApplication {
    
    // cs.appVersion: current App Version
    public var appVersion: String {
        let infoDict = Bundle.main.infoDictionary! as Dictionary<String, AnyObject>
        return infoDict["CFBundleShortVersionString"] as! String
    }
    
}


// MARK: - snapShot

public extension CSSwift where Base: UIApplication {
    
    public func snapShot(_ inView: UIView) -> UIImage {
        UIGraphicsBeginImageContext(inView.bounds.size)
        inView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let snapShot: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return snapShot
    }
    
}
