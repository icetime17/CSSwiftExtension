//
//  UIResponder+CSExtension.swift
//  CSSwiftExtension
//
//  Created by icetime17 on 2018/11/5.
//  Copyright © 2018 com.icetime17. All rights reserved.
//

import UIKit

public extension CSSwift where Base: UIResponder {

    // cs.currentViewController: current UIViewController
    public var currentViewController: UIViewController? {
        var responder = base.next
        while responder != nil {
            if responder!.isKind(of: UIViewController.self) {
                return (responder as! UIViewController)
            }
            responder = responder?.next
        }
        return nil
    }
}
