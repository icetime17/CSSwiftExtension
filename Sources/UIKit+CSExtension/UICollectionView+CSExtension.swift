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
    var numberOfAllItems: Int {
        var itemCount = 0
        for section in 0..<base.numberOfSections {
            itemCount += base.numberOfItems(inSection: section)
        }
        return itemCount
    }
    
    var firstIndexPath: IndexPath? {
        let numberOfSections = base.numberOfSections
        if numberOfSections == 0 {
            return nil
        }
        
        let numberOfItemsOfFirstSection = base.numberOfItems(inSection: 0)
        if numberOfItemsOfFirstSection == 0 {
            return nil
        }
        
        return IndexPath(item: 0, section: 0)
    }
    
    var lastIndexPath: IndexPath? {
        let numberOfSections = base.numberOfSections
        if numberOfSections == 0 {
            return nil
        }
        
        let numberOfItemsOfLastSection = base.numberOfItems(inSection: numberOfSections - 1)
        if numberOfItemsOfLastSection == 0 {
            return nil
        }
        
        return IndexPath(item: numberOfItemsOfLastSection - 1, section: numberOfSections - 1)
    }
    
}

public extension CSSwift where Base: UICollectionView {
    func scrollToFirstCell(scrollPosition: UICollectionView.ScrollPosition,
                                 animated: Bool,
                                 completion: CS_ClosureWithBool? = nil) {
        let numberOfSections = base.numberOfSections
        if numberOfSections == 0 {
            if let completion = completion {
                completion(false)
            }
            
            return
        }
        
        let numberOfItemsOfFirstSection = base.numberOfItems(inSection: 0)
        if numberOfItemsOfFirstSection == 0 {
            if let completion = completion {
                completion(false)
            }
            
            return
        }
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        base.scrollToItem(at: firstIndexPath, at: scrollPosition, animated: animated)
        if let completion = completion {
            completion(true)
        }
    }
    
    func scrollToLastCell(scrollPosition: UICollectionView.ScrollPosition,
                                 animated: Bool,
                                 completion: CS_ClosureWithBool? = nil) {
        let numberOfSections = base.numberOfSections
        if numberOfSections == 0 {
            if let completion = completion {
                completion(false)
            }
            return
        }
        
        let numberOfItemsOfLastSection = base.numberOfItems(inSection: numberOfSections - 1)
        if numberOfItemsOfLastSection == 0 {
            if let completion = completion {
                completion(false)
            }
            return
        }
        
        let lastIndexPath = IndexPath(item: numberOfItemsOfLastSection - 1,
                                      section: numberOfSections - 1)
        base.scrollToItem(at: lastIndexPath, at: scrollPosition, animated: animated)
        if let completion = completion {
            completion(true)
        }
    }
}

/*
// MARK: - reuse
extension UICollectionViewCell: ReusableView {
    
}

extension UICollectionViewCell: NibLoadable {
    
}

/*
public typealias ReusableNibView = ReusableView & NibLoadable
public protocol TestProtocol: ReusableView, NibLoadable {
    
}
 */

public extension CSSwift where Base: UICollectionView {
    
    func registerNib<T: UICollectionViewCell>(_: T.Type) where T: ReusableView & NibLoadable {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        base.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = base.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("CSSwiftExtension: Could not dequeue cell with identifier \(T.reuseIdentifier)")
        }
        return cell
    }
    
}
*/
