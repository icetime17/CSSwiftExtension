//
//  UIApplication+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

// MARK: - UIApplication

public extension UIApplication {
    
    // cs_appDelegate: current AppDelegate
    func cs_appDelegate() -> UIApplicationDelegate {
        return UIApplication.sharedApplication().delegate!
    }
    
    // cs_currentViewController: current UIViewController
    func cs_currentViewController() -> UIViewController {
        let window = self.cs_appDelegate().window
        var viewController = window!!.rootViewController
        
        while ((viewController?.presentedViewController) != nil) {
            viewController = viewController?.presentedViewController
            
            if ((viewController?.isKindOfClass(UINavigationController.classForCoder())) == true) {
                viewController = (viewController as! UINavigationController).visibleViewController
            } else if ((viewController?.isKindOfClass(UITabBarController.classForCoder())) == true) {
                viewController = (viewController as! UITabBarController).selectedViewController
            }
        }
        
        return viewController!;
    }
    
}


// MARK: - App Version Related

public extension UIApplication {
    
    // cs_appVersion: current App Version
    func cs_appVersion() -> String {
        let infoDict = NSBundle.mainBundle().infoDictionary! as Dictionary<String, AnyObject>
        return infoDict["CFBundleShortVersionString"] as! String
    }
    
    /**
     current App Version released in AppStore
     
     - parameter appId: appId in AppStore
     
     - returns: lastest appVersion in AppStore
     */
    func cs_appVersionInAppStore(appId: String) -> String {
        var appVersion = ""
        
        let url = "https://itunes.apple.com/lookup?id=\(appId)"
        let request = NSURLRequest(URL: NSURL(string: url)!)
        
        let semaphore = dispatch_semaphore_create(0)
        
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request)
        { (data, response, error) in
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                if let results = jsonData["results"]! {
                    assert(results.count != 0, "results should not be null")

                    appVersion = results.firstObject!?["version"]! as! String
                }
                
                dispatch_semaphore_signal(semaphore)
                
            } catch {
            
            }
        }
        dataTask.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
        return appVersion
    }
    
    /**
     Check whether this version of running App released or not.
     For example:
     Version of running App is 1.3, and app version in AppStore is 1.2,
     then, this method will return false.
     Several days later, app version in AppStore promotes to be 1.3 or 1.4,
     then this method will return true.
     
     - parameter appId: appId in AppStore
     
     - returns: true or false
     */
    func cs_isRunningAppVersionReleased(appId: String) -> Bool {
        let appVersionInAppStore = self.cs_appVersionInAppStore(appId)
        
        if self.cs_appVersion().compare(appVersionInAppStore) != .OrderedDescending {
            return true
        }
        
        return false
    }
    
}


// MARK: - snapShot

public extension UIApplication {
    
    func cs_snapShot(inView: UIView) -> UIImage {
        UIGraphicsBeginImageContext(inView.bounds.size)
        inView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let snapShot: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapShot
    }
    
}