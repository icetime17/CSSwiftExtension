//
//  CSNetworkManager.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/25.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

public class CSNetworkManager: NSObject {

    
    public class func sharedInstance() -> CSNetworkManager {
        struct temps {
            static var sharedInstance: CSNetworkManager?
            static var onceToken: dispatch_once_t = 0
        }
        
        dispatch_once(&temps.onceToken) { () -> Void in
            temps.sharedInstance = CSNetworkManager()
        }
        
        return temps.sharedInstance!
    }
    
    /**
     Send GET request.
     
     - parameter urlString:         url
     - parameter completionHandler: completionHandler to execute after getting response
     */
    public class func cs_GET(urlString: String, completionHandler: (jsonObject: AnyObject) -> Void) {
        let request = NSURLRequest(URL: NSURL(string: urlString)!)
        
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request)
        { (data, response, error) in
            do {
                let jsonObject = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                
                completionHandler(jsonObject: jsonObject)
                
            } catch {
                
            }
        }
        dataTask.resume()
    }
    
    /**
     Get Synchronous JSON response from an URL using Semaphore.
     
     - parameter urlString:         url
     - parameter completionHandler: completionHandler to execute after getting response
     
     - returns: JSON format object
     */
    public class func cs_getJSONObjectSynchronously(urlString: String, completionHandler: (jsonObject: AnyObject) -> Void) -> AnyObject {
        var jsonObject: AnyObject!
        
        
        let request = NSURLRequest(URL: NSURL(string: urlString)!)
        
        let semaphore = dispatch_semaphore_create(0)
        
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request)
        { (data, response, error) in
            do {
                jsonObject = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                
                completionHandler(jsonObject: jsonObject)
                
                dispatch_semaphore_signal(semaphore)
                
            } catch {
                
            }
        }
        dataTask.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
        return jsonObject
    }
    
}
