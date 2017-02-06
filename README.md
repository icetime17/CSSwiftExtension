## CSSwiftExtension

[![Build Status](https://travis-ci.org/icetime17/CSSwiftExtension.svg?branch=master)](https://travis-ci.org/icetime17/CSSwiftExtension)
[![Cocoapods](https://img.shields.io/cocoapods/v/CSSwiftExtension.svg)](https://cocoapods.org/pods/CSSwiftExtension)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://github.com/icetime17/CSSwiftExtension)
[![Xcode](https://img.shields.io/badge/Xcode-8.0-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

Some ***useful extension for Swift*** to boost your productivity.


## Requirements:
Xcode 8 (or later) with Swift 3. This library is made for iOS 8 or later.


## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate CSSwiftExtension into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'CSSwiftExtension'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate CSSwiftExtension into your Xcode project using Carthage, specify it in your `Cartfile`:

```
github "icetime17/CSSwiftExtension"
```

Run `carthage update` to build the framework and drag the built `CSSwiftExtension.framework` in folder /Carthage/Build/iOS into your Xcode project.

### Manually

Add the ***Sources*** folder to your Xcode project to use all extensions, or a specific extension.


## Usage

### Foundation

#### String extension
```Swift
let string = " hello 17, this is my city "
let a = string.cs_trimmed
let b = string.cs_length
aNonUTF8String.cs_utf8String

let regExp_email = "^[a-zA-Z0-9]{1,}@[a-zA-Z0-9]{1,}\\.[a-zA-Z]{2,}$"
cs_validateWithRegExp(regExp: regExp_email)
```

#### Array extension
```Swift
[1, 5, 10].cs_sum
["a", "b", "c", "a", "c"].cs_removeDuplicates()
```


### UIKit

#### UIApplication extension
```Swift
UIApplication.shared.cs.appVersion
UIApplication.shared.cs.currentViewController
```

#### UIColor extension
```Swift
imageView.backgroundColor = UIColor(hexString: 0x123456, alpha: 0.5)
imageView.backgroundColor = UIColor.cs.random
```

#### UIImage extension
```Swift
guard let image = UIImage(named: "Model.jpg") else { return }
let a = image.cs.imageMirrored
let b = image.cs.imageCropped(bounds: CGRect(x: 0, y: 0, width: 200, height: 200))
let c = image.cs.imageWithNormalOrientation
let d = image.cs.imageRotatedByDegrees(degrees: 90)
let e = image.cs.imageWithCornerRadius(cornerRadius: 100)
let f = image.cs.imageScaledToSize(targetSize: CGSize(width: 300, height: 300), withOriginalRatio: true)
let g = image.cs.wechatShareThumbnail
let h = image.cs.grayScale

// Thanks to https://github.com/bahlo/SwiftGif for gif support
aImageView.loadGif(name: "Railway")
aImageView.image = UIImage.gif(name: "Railway")
```

#### UIView extension
```Swift
imageView.cs_snapShot()
let aView = AView.cs.loadFromNib("AView") as? AView
aView.setCornerRadius(radius: 20)
aView.setCornerRadius(corners: [.bottomLeft, .bottomRight], radius: 20)
```

#### UIImageView extension
```Swift
let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 500), blurEffectStyle: .light)
```

#### UITableView extension
```Swift
aTableView.cs.removeEmptyFooter()
aTableView.cs.scrollToTop(animated: true)

tableView.cs_register(MyTableViewCell.self)
let cell = tableView.cs_dequeueReusableCell(forIndexPath: indexPath) as MyTableViewCell
```

#### UIButton extension
```Swift
btnTest.cs_acceptEventInterval = 2 // to avoid UIButton's multiple click operation
btnTest.cs.setBackgroundColor(UIColor.blue, for: .normal) // set backgroundColor
btnTest.cs.setBackgroundColor(UIColor.red, for: .highlighted)
```

#### CGPoint extension
```Swift
aPoint.cs_distance(toPoint: bPoint)
CGPoint.cs_distance(fromPoint: aPoint, toPoint: bPoint)
```

#### DispatchQueue extension
```Swift
DispatchQueue.cs.delay(2) {
    print("delay action")
}
DispatchQueue.cs.global {
    print("global action")
    DispatchQueue.cs.main {
        print("main action")
    }
}
```


## Contact

If you find an issue, just open a ticket. Pull requests are warmly welcome as well.


## License

CSSwiftExtension is released under the MIT license. See LICENSE.md for details.
