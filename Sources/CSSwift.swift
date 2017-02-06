//
//  CSSwift.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/2/6.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//


public struct CSSwift<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

/**
 A type that has CSSwift extensions.
 */
public protocol CSSwiftCompatible {
    associatedtype CompatibleType
    
    static var cs: CSSwift<CompatibleType>.Type { get set }
    
    var cs: CSSwift<CompatibleType> { get set }
}

public extension CSSwiftCompatible {

    public static var cs: CSSwift<Self>.Type {
        get {
            return CSSwift<Self>.self
        }
        set {
        
        }
    }

    public var cs: CSSwift<Self> {
        get {
            return CSSwift(self)
        }
        set {
        
        }
    }
    
}


import UIKit
import Foundation

/// Extend NSObject with `cs` proxy.
extension NSObject: CSSwiftCompatible       { }

