//
//  UICollectionView+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/1/3.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

public extension CSSwift where Base: UICollectionView {
    
    // number of all items
    public var numberOfAllItems: Int {
        var itemCount = 0
        for section in 0..<base.numberOfSections {
            itemCount += base.numberOfItems(inSection: section)
        }
        return itemCount
    }
    
}


// MARK: - reuse
extension UICollectionViewCell: ReusableView {
    
}

extension UICollectionViewCell: NibLoadable {
    
}

public extension UICollectionView {
    
    public func cs_register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadable {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    public func cs_dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("CSSwiftExtension: Could not dequeue cell with identifier \(T.reuseIdentifier)")
        }
        return cell
    }
    
}
