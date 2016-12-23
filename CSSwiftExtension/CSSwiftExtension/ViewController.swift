//
//  ViewController.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/22.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testBlurImageView()
    }
    
    private func testBlurImageView() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 500), blurEffectStyle: .light)
        imageView.backgroundColor = UIColor(hexString: 0x123456, alpha: 0.5)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.center = view.center
        imageView.image = UIImage(named: "Model.jpg")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

