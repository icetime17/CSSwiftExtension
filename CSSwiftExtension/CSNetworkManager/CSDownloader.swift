//
//  CSDownloader.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/7/11.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

class CSDownloaderData: NSObject {
    let url: String
    
    let fileManager = NSFileManager.defaultManager()
    
    let localPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    
    let savePath: String
    
    var dataDownloaded: NSData? // 保存断点下载的数据
    
    init(url: String, name: String) {
        self.url = url
        self.savePath = localPath.stringByAppendingString("/\(name)")
    }
}

protocol CSDownloaderDelegate {
    
    func CSDownloaderStart()
    
    func CSDownloaderComplete()
    
    func CSDownloaderCancel()
    
    func CSDownloaderUpdateSpeed(speed: String)
    
    func CSDownloaderUpdateProgress(progress: Int)
    
}

class CSDownloader: NSObject, NSURLSessionDelegate {
    var delegate: CSDownloaderDelegate!
    
    var data: CSDownloaderData
    
    var task: NSURLSessionDownloadTask?
    
    // 声明的let属性, 也可以在init中赋值, 仅此两种机会.
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    
    var timer: NSTimer?
    
    var speed: [Int] = []
    
    var totalBytesWritten: Int64 = 0
    var totalBytesExpectedToWrite: Int64 = 0
    
    init(urlString: String, fileName: String) {
        self.data = CSDownloaderData(url: urlString, name: fileName)
    }
    
    func startDownloadTask() {
        let session = NSURLSession(configuration: config, delegate: self, delegateQueue: nil)
        
        print("filePath : \(self.data.savePath)")
        
        if let dataDownloaded = self.data.dataDownloaded {
            self.task = session.downloadTaskWithResumeData(dataDownloaded)
            print("continue downloading")
            self.data.dataDownloaded = nil
        } else {
            if let url = NSURL(string: self.data.url) {
                self.task = session.downloadTaskWithURL(url)
                print("start downloading")
            }
        }
        
        self.task?.resume()
        
        self.timer?.invalidate()
        self.timer = nil
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: #selector(self.actionNSTimer), userInfo: nil, repeats: true)
        
        self.delegate.CSDownloaderStart()
    }
    
    func pauseDownloadTask() {
        if let task = self.task {
            if task.state == .Running {
                
                // 停止任务并生成一个NSData(已下载的数据), 将其存起来即可
                task.cancelByProducingResumeData({ (data) in
                    self.data.dataDownloaded = data
                    self.speed = []
                    self.task = nil
                    self.timer?.invalidate()
                    self.timer = nil
                    print("paused")
                })
            }
        }
    }
    
    func cancelDownloadTask() {
        if let task = self.task {
            task.cancel()
            self.task = nil
        }
        
        self.data.dataDownloaded = nil
        self.speed = []
        self.timer?.invalidate()
        self.timer = nil
        print("canceled")
        
        self.totalBytesWritten = 0
        self.totalBytesExpectedToWrite = 0
        
        self.delegate.CSDownloaderCancel()
    }
    
    func actionNSTimer() {
        self.delegate.CSDownloaderUpdateSpeed(self.getSpeed())
        
        if self.totalBytesExpectedToWrite != 0 {
            self.delegate.CSDownloaderUpdateProgress(Int(Float(self.totalBytesWritten) / Float(self.totalBytesExpectedToWrite) * 100))
        }
    }
    
    private func getSpeed() -> String {
        // data 为一个timer周期内总共写入数据的大小bytes
        var data = 0
        for tmpData in speed {
            data += tmpData
        }
        speed = []
        
        return "\(data/256)"
    }
    
    // NSURLSessionDelegate
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        print("download successful")
        
        self.timer?.invalidate()
        self.timer = nil
        
        if let fromPath = location.path {
            do {
                if self.data.fileManager.fileExistsAtPath(self.data.savePath) {
                    try self.data.fileManager.removeItemAtPath(self.data.savePath)
                }
                try self.data.fileManager.moveItemAtPath(fromPath, toPath: self.data.savePath)
                
                self.delegate.CSDownloaderComplete()
            } catch {
                print("failed")
            }
        } else {
            print("wrong fromPath")
        }
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        self.speed.append(Int(bytesWritten))
        
        self.totalBytesWritten = totalBytesWritten
        self.totalBytesExpectedToWrite = totalBytesExpectedToWrite
    }
    
}
