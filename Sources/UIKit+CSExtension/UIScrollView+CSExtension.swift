//
//  UIScrollView+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 2017/9/13.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

public extension CSSwift where Base: UIScrollView {
    
    public func scrollToTop(animated: Bool = true) {
        base.setContentOffset(CGPoint.zero, animated: animated)
    }
    
    public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: base.contentSize.height - base.bounds.height)
        if bottomOffset.y > 0 {
            base.setContentOffset(bottomOffset, animated: animated)
        }
    }
    
}
