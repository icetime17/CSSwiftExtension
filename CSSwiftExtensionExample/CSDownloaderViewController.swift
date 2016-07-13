//
//  CSDownloaderViewController.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/7/10.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

class CSDownloaderViewController: UIViewController, CSDownloaderDelegate {

    var lbProgress: UILabel!
    var lbSpeed: UILabel!
    
    var btnStart: UIButton!
    var btnStop: UIButton!
    
    var downloader: CSDownloader!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.lightGrayColor()
        
        self.lbProgress = UILabel(frame: CGRectMake(10, 50, 150, 50))
        self.lbProgress.textAlignment = NSTextAlignment.Center
        self.lbProgress.text = "Progress : 0"
        self.view.addSubview(self.lbProgress)
        
        self.lbSpeed = UILabel(frame: CGRectMake(200, 50, 150, 50))
        self.lbSpeed.textAlignment = NSTextAlignment.Center
        self.lbSpeed.text = "Speed : 0"
        self.view.addSubview(self.lbSpeed)
        
        self.addBtnStart()
        
        self.addBtnStop()
        
        let urlString = "http://lotus.sp.iqiyi.com/ota?id=&pubplatform=6&pubarea=pcltdown_15030501&qipuid=&u=&pu=2054576563"
        downloader = CSDownloader(urlString: urlString, fileName: "image.dmg")
        downloader.delegate = self
    }

    func addBtnStart() {
        btnStart = UIButton(frame: CGRectMake(20, 150, 100, 50))
        btnStart.setTitle("Start", forState: UIControlState.Normal)
        btnStart.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btnStart.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        btnStart.backgroundColor = UIColor.greenColor()
        btnStart.cs_setBackgroundColor(UIColor.greenColor(), forState: .Normal)
        btnStart.cs_setBackgroundColor(UIColor.blueColor(), forState: .Highlighted)
        self.view.addSubview(btnStart)
        
        btnStart.addTarget(self, action: #selector(CSDownloaderViewController.actionStart(_:)), forControlEvents: .TouchUpInside)
    }
    
    func addBtnStop() {
        btnStop = UIButton(frame: CGRectMake(150, 150, 100, 50))
        btnStop.setTitle("Stop", forState: UIControlState.Normal)
        btnStop.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btnStop.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        btnStop.backgroundColor = UIColor.greenColor()
        btnStop.cs_setBackgroundColor(UIColor.greenColor(), forState: .Normal)
        btnStop.cs_setBackgroundColor(UIColor.blueColor(), forState: .Highlighted)
        self.view.addSubview(btnStop)
        
        btnStop.addTarget(self, action: #selector(CSDownloaderViewController.actionStop(_:)), forControlEvents: .TouchUpInside)
    }
    
    func actionStart(sender: UIButton) {
        if sender.titleLabel?.text == "Start" {
            downloader.startDownloadTask()
            
            sender.setTitle("Pause", forState: UIControlState.Normal)
        } else if sender.titleLabel?.text == "Pause" {
            downloader.pauseDownloadTask()
            
            sender.setTitle("Start", forState: UIControlState.Normal)
        }
    }
    
    func actionStop(sender: UIButton) {
        downloader.cancelDownloadTask()
        
        self.btnStart.setTitle("Start", forState: UIControlState.Normal)
    }
    
    // MARK: - CSDownloaderDelegate
    
    func CSDownloaderStart() {
    
    }
    
    func CSDownloaderComplete() {
        print("complete")
        self.lbSpeed.text = "Speed : 0"
        self.lbProgress.text = "Progress : 100"
    }
    
    func CSDownloaderCancel() {
        self.lbSpeed.text = "Speed : 0"
        self.lbProgress.text = "Progress : 0"
    }
    
    func CSDownloaderUpdateSpeed(speed: String) {
        self.lbSpeed.text = "Speed : \(speed)"
    }
    
    func CSDownloaderUpdateProgress(progress: Int) {
        self.lbProgress.text = "Progress : \(progress)"
    }
    
}
