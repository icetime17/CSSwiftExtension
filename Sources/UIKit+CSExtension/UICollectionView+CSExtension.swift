//
//  UICollectionView+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/1/3.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    // number of all items
    public var cs_numberOfAllItems: Int {
        var itemCount = 0
        for section in 0..<numberOfSections {
            itemCount += numberOfItems(inSection: section)
        }
        return itemCount
    }
    
}
