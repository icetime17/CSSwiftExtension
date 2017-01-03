//
//  UITableView+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/1/3.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

public extension UITableView {
    
    // number of all rows
    public var cs_numberOfAllRows: Int {
        var rowCount = 0
        for section in 0..<numberOfSections {
            rowCount += numberOfRows(inSection: section)
        }
        return rowCount
    }
    
}

public extension UITableView {

    public func cs_removeEmptyFooter() {
        tableFooterView = UIView(frame: CGRect.zero)
    }
    
    public func cs_scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
    
    public func cs_scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.height)
        setContentOffset(bottomOffset, animated: animated)
    }
    
}
