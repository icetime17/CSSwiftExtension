## CSSwiftExtension

[![Build Status](https://travis-ci.org/icetime17/CSSwiftExtension.svg?branch=master)](https://travis-ci.org/icetime17/CSSwiftExtension)
[![Cocoapods](https://img.shields.io/cocoapods/v/CSSwiftExtension.svg)](https://cocoapods.org/pods/CSSwiftExtension)
[![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://github.com/icetime17/CSSwiftExtension)
[![Xcode](https://img.shields.io/badge/Xcode-8.0-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

Some ***useful extension for Swift*** to boost your productivity.


## Requirements:
Xcode 8 (or later) with Swift 3. This library is made for iOS 8 or later, however most of the extensions should work on watchOS, tvOS, and macOS.


## Installation

### CocoaPods

```bash
pod 'CSSwiftExtension'
```

### Manually

Add the ***Sources*** folder to your Xcode project to use all extensions, or a specific extension.


## Usage

### Foundation

#### String extension
```Swift
let string = " hello 17, this is my city "
let a = string.cs_trim()
```

### UIKit

#### UIApplication extension
```Swift
UIApplication.shared.cs_appVersion()
UIApplication.shared.cs_currentViewController()
```

#### UIColor extension
```Swift
imageView.backgroundColor = UIColor(hexString: 0x123456, alpha: 0.5)
```

#### UIImage extension
```Swift
guard let image = UIImage(named: "Model.jpg") else { return }
let a = image.cs_imageMirrored()
let b = image.cs_imageCropped(bounds: CGRect(x: 0, y: 0, width: 200, height: 200))
let c = image.cs_imageWithNormalOrientation()
let d = image.cs_imageRotatedByDegrees(degrees: 90)
let e = image.cs_imageWithCornerRadius(cornerRadius: 100)
let f = image.cs_imageScaledToSize(targetSize: CGSize(width: 300, height: 300), withOriginalRatio: true)
let g = image.cs_wechatShareThumbnail()
let h = image.cs_grayScale()
```

#### UIImageView extension
```Swift
let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 500), blurEffectStyle: .light)
```

#### UIView extension
```Swift
imageView.cs_snapShot()
```


## Contact

If you find an issue, just open a ticket. Pull requests are warmly welcome as well.


## License

CSSwiftExtension is released under the MIT license. See LICENSE.md for details.
