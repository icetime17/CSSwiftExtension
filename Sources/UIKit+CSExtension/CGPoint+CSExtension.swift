//
//  CGPoint+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/1/3.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

public extension CGPoint {

    public static func cs_distance(fromPoint: CGPoint, toPoint: CGPoint) -> CGFloat {
        return sqrt(pow(toPoint.x - fromPoint.x, 2) + pow(toPoint.y - fromPoint.y, 2))
    }
    
    public func cs_distance(toPoint: CGPoint) -> CGFloat {
        return CGPoint.cs_distance(fromPoint: self, toPoint: toPoint)
    }
    
}
