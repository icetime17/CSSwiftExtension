//
//  UIImageView+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit

// MARK: - UIImageView with BlurEffect

public extension UIImageView {

    // Add blur effect UIImageView
    public convenience init(frame: CGRect, blurEffectStyle: UIBlurEffectStyle) {
        self.init(frame: frame)
        
        let blurView = UIVisualEffectView(frame: self.bounds)
        self.addSubview(blurView)
        
        blurView.effect = UIBlurEffect(style: blurEffectStyle)
    }
    
}
