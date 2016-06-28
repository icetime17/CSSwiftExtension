//
//  AViewController.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

class AViewController: UIViewController {

    var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        self.addBackBtn()
    }
    
    func addBackBtn() {
        btn = UIButton(frame: CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width - 200, 50))
        btn.setTitle("Back", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        btn.layer.borderColor = UIColor.redColor().CGColor
        btn.layer.borderWidth = 2.0
        btn.addTarget(self, action: #selector(AViewController.actionBack), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
    }
    
    func actionBack() {
//        btn.cs_left = btn.cs_left + 20
//        btn.cs_right = btn.cs_right + 20
//        btn.cs_top = btn.cs_top - 20
//        btn.cs_bottom = btn.cs_bottom - 20
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print(UIApplication.sharedApplication().cs_currentViewController())
    }
    
}
