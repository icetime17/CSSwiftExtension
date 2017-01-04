//
//  UIApplication+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit

// MARK: - UIApplication

public extension UIApplication {
    
    // cs_appDelegate: current AppDelegate
    public var cs_appDelegate: UIApplicationDelegate {
        return UIApplication.shared.delegate!
    }
    
    // cs_currentViewController: current UIViewController
    public var cs_currentViewController: UIViewController {
        let window = self.cs_appDelegate.window
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

public extension UIApplication {
    
    // cs_appVersion: current App Version
    public var cs_appVersion: String {
        let infoDict = Bundle.main.infoDictionary! as Dictionary<String, AnyObject>
        return infoDict["CFBundleShortVersionString"] as! String
    }
    
}


// MARK: - snapShot

public extension UIApplication {
    
    public func cs_snapShot(_ inView: UIView) -> UIImage {
        UIGraphicsBeginImageContext(inView.bounds.size)
        inView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let snapShot: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return snapShot
    }
    
}
