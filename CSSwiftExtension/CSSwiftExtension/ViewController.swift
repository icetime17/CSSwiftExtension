//
//  ViewController.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/22.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView: UIImageView!
    var anotherImageView: UIImageView!
    
    var btnTest: UIButton!
    
    var tapGesture: UITapGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testBlurImageView()
        
        testAnotherImageView()
        
        addBtnTest()
        
        testImageWatermark()
        
        var json: CS_JSONDictionary = [
            "name":"chris",
            "age":18,
        ]
        json.updateValue(17, forKey: "river")
        json["city"] = "shanghai"
        print(json)
        
        let appVersion = UIApplication.shared.cs.appVersion
        print(appVersion)
        print(appVersion.cs_isEqualTo("0.1.1"))
        print(appVersion.cs_isHigherThan("0.0.9"))
        print(appVersion.cs_isEqualToOrHigherThan("0.1.1"))
        print(appVersion.cs_isHigherThan("1.0.0"))
    }
    
    @discardableResult // ignore return value
    private func addBtnTest() -> Int {
        btnTest = UIButton(frame: CGRect(x: 50, y: 50, width: 100, height: 30))
        btnTest.backgroundColor = UIColor.black
        view.addSubview(btnTest)
        btnTest.setTitle("Test", for: .normal)
        btnTest.addTarget(self, action: .actionBtnTest, for: .touchUpInside)
        
        btnTest.cs_acceptEventInterval = 2
        
        btnTest.cs.setBackgroundColor(UIColor.blue, for: .normal)
        btnTest.cs.setBackgroundColor(UIColor.red, for: .highlighted)
        
        return 1
    }
    
    private func testBlurImageView() {
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 500), blurEffectStyle: .light)
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        imageView.backgroundColor = UIColor(hexString: 0x123456, alpha: 0.5)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.center = view.center
        imageView.image = UIImage(named: "Model.jpg")
    }

    func testAnotherImageView() {
        anotherImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        anotherImageView.backgroundColor = UIColor(hexString: 0x123456, alpha: 0.5)
        anotherImageView.contentMode = .scaleAspectFit
        view.addSubview(anotherImageView)
        anotherImageView.center = view.center
        anotherImageView.image = UIImage(named: "Model.jpg")?.cs.grayScale
        anotherImageView.alpha = 0.5
        
//        anotherImageView.loadGif(name: "Railway")
//        anotherImageView.image = UIImage.gif(name: "Railway")
        
        
        CS_Print(anotherImageView.isUserInteractionEnabled)
        
        anotherImageView.isUserInteractionEnabled = true
        tapGesture = UITapGestureRecognizer(target: self, action: .actionTapGesture)
        anotherImageView.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    func actionBtnTest() {
        btnTest.cs.setCornerRadius(radius: 20)
        
        guard let aView = AView.cs.loadFromNib("AView") as? AView else { return }
        aView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        aView.center = view.center
        view.addSubview(aView)
        var txt = "TestViewveryveryverylong"
        if txt.cs_isTextWidthOutside(aView: aView, with: UIFont.systemFont(ofSize: 7)) {
            print("long")
            txt = "another"
        } else {
            print("ok")
        }
        aView.lbTitle.text = txt
        aView.lbTitle.backgroundColor = UIColor.cs.random
        
        aView.cs.breathAnimation()
//        aView.cs.hideAnimation()
        
//        aView.cs.popAnimation()
//        aView.cs.popAnimation(duration: 1)
//        aView.cs.popAnimation { (finished) in
//            print("popAnimation : \(finished)")
//        }
//        aView.cs.popAnimation(duration: 1) { (finished) in
//            print("popAnimation : \(finished)")
//        }
        
//        aView.cs.raiseAnimation()
//        aView.cs.raiseAnimation(duration: 1)
//        aView.cs.raiseAnimation { (finished) in
//            print("raiseAnimation : \(finished)")
//        }
//        aView.cs.raiseAnimation(duration: 1) { (finished) in
//            print("raiseAnimation : \(finished)")
//        }
        
//        aView.cs.dropAnimation()
//        aView.cs.dropAnimation(duration: 1)
//        aView.cs.dropAnimation { (finished) in
//            print("dropAnimation : \(finished)")
//        }
//        aView.cs.dropAnimation(duration: 1) { (finished) in
//            print("dropAnimation : \(finished)")
//        }
    }
    
    @objc
    func actionTapGesture() {
        CS_Print(#function)
        
        anotherImageView.cs.removeGestureRecognizers()
    }
}


extension ViewController {
    func testImageWatermark() {
        guard let img = UIImage(named: "Model.jpg") else { return }
        let ret1 = img.cs.imageWithWatermark(img: img,
                                            rect: CGRect(x: 0, y: 0, width: 200, height: 200))
        CS_Print(ret1.size)
        
        let ret11 = img.cs.imageWithWatermark(img: img,
                                              center: img.cs.center,
                                              size: CGSize(width: 200, height: 200))
        CS_Print(ret11.size)
        
        
        let ret2 = img.cs.imageWithWatermark(text: "This is Watermark",
                                             point: CGPoint(x: 100, y: 100),
                                             font: UIFont.systemFont(ofSize: 50))
        CS_Print(ret2.size)
        
        let style = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        style.alignment = .center
        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont.systemFont(ofSize: 50),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.paragraphStyle.rawValue): style,
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white,
            ]
        let ret3 = img.cs.imageWithWatermark(text: "This is Watermark",
                                             point: CGPoint(x: 100, y: 100),
                                             attributes: attributes)
        CS_Print(ret3.size)
    }
}

// MARK: - Selector
private extension Selector {
    static let actionBtnTest = #selector(ViewController.actionBtnTest)
    static let actionTapGesture = #selector(ViewController.actionTapGesture)
}


