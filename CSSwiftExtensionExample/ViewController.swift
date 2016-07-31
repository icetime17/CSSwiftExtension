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
        
        self.testBtnBackgroundColor()
        
        self.testCSDownloader()
        
        self.testImageView_CSBlur()
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
        btn.cs_accpetEventInterval = 5.0
        
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

    func testBtnBackgroundColor() {
        let btn = UIButton(frame: CGRectMake(0, 100, self.view.frame.size.width, 50))
        btn.setTitle("UIButton BackgroundColor", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        self.view.addSubview(btn)
        
        btn.backgroundColor = UIColor.greenColor()
        btn.cs_setBackgroundColor(UIColor.greenColor(), forState: .Normal)
        btn.cs_setBackgroundColor(UIColor.blueColor(), forState: .Highlighted)
    }
 
    func testCSDownloader() {
        let btn = UIButton(frame: CGRectMake(0, 200, self.view.frame.size.width, 50))
        btn.setTitle("CSDownloader", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        btn.backgroundColor = UIColor.greenColor()
        btn.cs_setBackgroundColor(UIColor.greenColor(), forState: .Normal)
        btn.cs_setBackgroundColor(UIColor.blueColor(), forState: .Highlighted)
        self.view.addSubview(btn)
        
        btn.addTarget(self, action: #selector(ViewController.actionCSDownloader), forControlEvents: .TouchUpInside)
    }
    
    func actionCSDownloader() {
        let vc = CSDownloaderViewController()
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func testImageView_CSBlur() {
        let imageBackground = UIImageView(frame: self.view.frame, blurEffectStyle: .Light)
        imageBackground.image = UIImage(named: "Model.jpg")
        self.view.insertSubview(imageBackground, atIndex: 0)
        
        let imageViewBlur = UIImageView(frame: CGRectMake(100, 300, 200, 300))
        imageViewBlur.image = UIImage(named: "Model.jpg")?.cs_imageWithCornerRadius(20)
        self.view.addSubview(imageViewBlur)
    }
    
}

