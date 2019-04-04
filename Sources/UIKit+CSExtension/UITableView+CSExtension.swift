//
//  UITableView+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/1/3.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

public extension CSSwift where Base: UITableView {
    
    // number of all rows
    var numberOfAllRows: Int {
        var rowCount = 0
        for section in 0..<base.numberOfSections {
            rowCount += base.numberOfRows(inSection: section)
        }
        return rowCount
    }
    
}

public extension CSSwift where Base: UITableView {

    func removeEmptyFooter() {
        base.tableFooterView = UIView(frame: CGRect.zero)
    }
    
}

/*
// MARK: - reuse
extension UITableViewCell: ReusableView {
    
}

extension UITableViewCell: NibLoadable {
    
}

public extension CSSwift where Base: UITableView {
    
    func registerNib<T: UITableViewCell>(_: T.Type) where T: ReusableView & NibLoadable {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        base.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = base.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("CSSwiftExtension: Could not dequeue cell with identifier \(T.reuseIdentifier)")
        }
        return cell
    }
    
}
*/
