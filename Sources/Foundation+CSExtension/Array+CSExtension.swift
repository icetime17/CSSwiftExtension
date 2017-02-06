//
//  Array+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/1/3.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import Foundation

// MARK: - Integer
public extension Array where Element: Integer {
    
    public var cs_sum: Element {
        return reduce(0, +)
    }

}


// MARK: - Equatable
public extension Array where Element: Equatable {
    
    // remove duplicate element
    public mutating func cs_removeDuplicates() {
//        self = reduce([]) { (result, element) -> [Element] in
//            result.contains(element) ? result : result + [element]
//        }
        self = self.reduce([]) {
            $0.contains($1) ? $0 : $0 + [$1]
        }
    }
    
}

