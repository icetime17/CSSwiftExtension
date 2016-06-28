//
//  ViewController.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        print(UIApplication.sharedApplication().cs_currentViewController())
        
        self.testVC()
    }
    
    func testVC() {
        let btn = UIButton(frame: CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50))
        btn.setTitle("Demo", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        btn.layer.borderColor = UIColor.redColor().CGColor
        btn.layer.borderWidth = 2.0
        btn.addTarget(self, action: #selector(ViewController.actionBtn), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        
        let a = UIApplication.sharedApplication().cs_snapShot(self.view)
        let a1 = self.view.cs_snapShot()
        let b = UIApplication.sharedApplication().cs_snapShot(btn)
        let b1 = btn.cs_snapShot()
        let c = a.cs_imageScaledToSize(CGSizeMake(200, 200), withOriginalRatio: true)
        let d = a.cs_imageScaledToSize(CGSizeMake(200, 200), withOriginalRatio: false)
        let e = b.cs_imageScaledToSize(CGSizeMake(2000, 2000), withOriginalRatio: true)
        let f = b.cs_imageScaledToSize(CGSizeMake(2000, 2000), withOriginalRatio: false)
        
        print("Done")
    }
    
    func actionBtn() {
        let vcA = AViewController()
        self.presentViewController(vcA, animated: true, completion: nil)
    }

}

