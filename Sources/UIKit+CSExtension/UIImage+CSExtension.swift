//
//  UIImage+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit
import ImageIO

// MARK: - init
extension UIImage {
    
    /**
     UIImage init from an URL string. Synchronsize and NOT recommended.
     
     - parameter urlString: URL string
     
     - returns: UIImage
     */
    public convenience init(urlString: String) {
        let imageData = try! Data(contentsOf: URL(string: urlString)!)
        self.init(data: imageData)!
    }
    
    /**
     UIImage init from pure color
     
     - parameter pureColor: pure color
     - parameter targetSize:targetSize
     
     - returns: UIImage
     */
    public convenience init(pureColor: UIColor, targetSize: CGSize) {
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1)
        defer {
            UIGraphicsEndImageContext()
        }
        
        pureColor.setFill()
        UIRectFill(CGRect(origin: CGPoint.zero, size: targetSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        self.init(cgImage: image.cgImage!)
    }
    
}

public extension CSSwift where Base: UIImage {
    
    // center
    public var center: CGPoint {
        return CGPoint(x: base.size.width / 2, y: base.size.height / 2)
    }

}

// MARK: - save
public extension CSSwift where Base: UIImage {
    
    /**
     Save UIImage to file
     
     - parameter filePath:          file path
     - parameter compressionFactor: compression factor, only useful for JPEG format image. 
                                    Default to be 1.0.
     
     - returns: true or false
     */
    public func saveImageToFile(filePath: String, compressionFactor: CGFloat = 1.0) -> Bool {
        let imageData: NSData!
        if filePath.hasSuffix(".jpeg") {
            imageData = UIImageJPEGRepresentation(base, compressionFactor) as NSData!
        } else {
            imageData = UIImagePNGRepresentation(base)! as NSData!
        }
        
        
        if FileManager.default.fileExists(atPath: filePath) {
            do {
                try FileManager.default.removeItem(atPath: filePath)
            } catch {
                cs_print("This file (\(filePath)) exists already, and NSFileManager failed to remove it.")
                return false
            }
        }
        
        if FileManager.default.createFile(atPath: filePath, contents: imageData as Data?, attributes: nil) {
            return imageData.write(toFile: filePath, atomically: true)
        } else {
            cs_print("FileManager failed to create file at path: \(filePath).")
            return false
        }
    }
    
}

// MARK: - utility
public extension CSSwift where Base: UIImage {
    
    /**
     Crop UIImage
     
     - returns: UIImage cropped
     */
    public func imageCropped(bounds: CGRect) -> UIImage {
        let imageRef = base.cgImage!.cropping(to: bounds)
        let imageCropped = UIImage(cgImage: imageRef!)
        return imageCropped
    }
    
    /**
     Crop UIImage to fit target size
     
     - returns: UIImage cropped
     */
    public func imageCroppedToFit(targetSize: CGSize) -> UIImage {
        var widthImage: CGFloat = 0.0
        var heightImage: CGFloat = 0.0
        var rectRatioed: CGRect!
        
        if base.size.height / base.size.width < targetSize.height / targetSize.width {
            // 图片的height过小, 剪裁其width, 而height不变
            heightImage = base.size.height
            widthImage = heightImage * targetSize.width / targetSize.height
            rectRatioed = CGRect(x: (base.size.width - widthImage) / 2, y: 0, width: widthImage, height: heightImage)
        } else {
            // 图片的width过小, 剪裁其height, 而width不变
            widthImage = base.size.width
            heightImage = widthImage * targetSize.height / targetSize.width
            rectRatioed = CGRect(x: 0, y: (base.size.height - heightImage) / 2, width: widthImage, height: heightImage)
        }
        
        return imageCropped(bounds: rectRatioed)
    }
    
    /**
     Mirror UIImage
     
     - returns: UIImage mirrored
     */
    public var imageMirrored: UIImage {
        let width = base.size.width
        let height = base.size.height
        
        UIGraphicsBeginImageContext(base.size)
        defer {
            UIGraphicsEndImageContext()
        }
        
        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = .high
        
        context?.translateBy(x: width, y: height)
        context?.concatenate(CGAffineTransform(scaleX: -1.0, y: -1.0))
        context?.draw(base.cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let imageRef = context!.makeImage()
        let resultImage = UIImage(cgImage: imageRef!)
        
        return resultImage
    }
    
    /**
     Rotate UIImage to specified degress
     
     - parameter degress: degress to rotate
     
     - returns: UIImage rotated
     */
    public func imageRotatedByDegrees(degrees: CGFloat) -> UIImage {
        let radians = CGFloat(Double.pi) * degrees / 180.0
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height))
        rotatedViewBox.transform = CGAffineTransform(rotationAngle: radians)
        
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create bitmap context.
        UIGraphicsBeginImageContext(rotatedSize)
        defer {
            UIGraphicsEndImageContext()
        }
        
        let context = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and.
        context?.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)
        
        // Rotate the image context
        context?.rotate(by: radians)
        
        // Now, draw the rotated/scaled image into the context
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.draw(base.cgImage!, in: CGRect(x: -base.size.width / 2.0, y: -base.size.height / 2.0, width: base.size.width, height: base.size.height))
        
        let imageRotated = UIGraphicsGetImageFromCurrentImageContext()
        
        return imageRotated!
    }
    
    /**
     Scale UIImage to specified size.
     
     - parameter targetSize:        targetSize
     - parameter withOriginalRatio: whether the result UIImage should keep the original ratio
                                    Default to be true
     
     - returns: UIImage scaled
     */
    public func imageScaledToSize(targetSize: CGSize, withOriginalRatio: Bool = true) -> UIImage {
        var sizeFinal = targetSize
        
        if withOriginalRatio {
            let ratioOriginal = base.size.width / base.size.height
            let ratioTemp = targetSize.width / targetSize.height
            
            if ratioOriginal < ratioTemp {
                sizeFinal.width = targetSize.height * ratioOriginal
            } else if ratioOriginal > ratioTemp {
                sizeFinal.height = targetSize.width / ratioOriginal
            }
        }
        
        UIGraphicsBeginImageContext(sizeFinal)
        defer {
            UIGraphicsEndImageContext()
        }
        
        base.draw(in: CGRect(x: 0, y: 0, width: sizeFinal.width, height: sizeFinal.height))
        let imageScaled: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        return imageScaled
    }
    
    /**
     UIImage with corner radius without Off-Screen Rendering.
     Much better than setting layer.cornerRadius and layer.masksToBounds.
     
     - parameter cornerRadius: corner radius
     - parameter backgroundColor: backgroundColor, default clear color.
     
     - returns: UIImage
     */
    public func imageWithCornerRadius(cornerRadius: CGFloat, backgroundColor: UIColor = UIColor.clear) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height)
        
        UIGraphicsBeginImageContext(base.size)
        defer {
            UIGraphicsEndImageContext()
        }
        
        // Add a clip before drawing anything, in the shape of an rounded rect
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        
        backgroundColor.setFill()
        UIRectFill(rect)
        
        // Draw the image
        base.draw(in: rect)
        
        let imageWithCornerRadius = UIGraphicsGetImageFromCurrentImageContext()
        
        return imageWithCornerRadius!
    }
    
    public var imageWithNormalOrientation: UIImage {
        if base.imageOrientation == UIImageOrientation.up {
            return base
        }
        
        UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        
        base.draw(in: CGRect(origin: CGPoint.zero, size: base.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return normalizedImage!
    }
    
    public var grayScale: UIImage {
        // Create image rectangle with current image width/height
        let rect = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height);
        // Grayscale color space
        let colorSpace = CGColorSpaceCreateDeviceGray()
        // Create bitmap content with current image size and grayscale colorspace
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        // Draw image into current context, with specified rectangle
        // using previously defined context (with grayscale colorspace)
        guard let context = CGContext(data: nil, width: Int(base.size.width), height: Int(base.size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else { return base }
        
        context.setFillColor(UIColor.clear.cgColor)
        context.fill(rect)
        
        context.draw(base.cgImage!, in: rect)
        // Create bitmap image info from pixel data in current context
        guard let imageRef = context.makeImage() else { return base }
        // Create a new UIImage object
        let newImage = UIImage(cgImage: imageRef)
        
        // Release colorspace, context and bitmap information
        
        // Return the new grayscale image
        return newImage;
    }
    
}

// MARK: - Watermark
public extension CSSwift where Base: UIImage {
    // Add image watermark via rect
    public func imageWithWatermark(img: UIImage, rect: CGRect) -> UIImage {
        p_setUpImageContext()
        
        img.draw(in: rect)
        
        let r = p_imageFromContext()
        
        p_tearDownImageContext()
        
        return r
    }
    
    // Add image watermark via center and size
    public func imageWithWatermark(img: UIImage,
                                   center: CGPoint,
                                   size: CGSize) -> UIImage {
        let rect = CGRect(x: center.x - size.width / 2,
                          y: center.y - size.height / 2,
                          width: size.width,
                          height: size.height)
        
        return imageWithWatermark(img: img, rect: rect)
    }
    
    // Text
    public func imageWithWatermark(text: String,
                                   point: CGPoint,
                                   font: UIFont,
                                   color: UIColor = .white) -> UIImage {
        let style = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        style.alignment = .center
        let attributes = [
            NSFontAttributeName: font,
            NSParagraphStyleAttributeName: style,
            NSForegroundColorAttributeName: color,
        ]
        
        return imageWithWatermark(text: text, point: point, attributes: attributes)
    }
    
    // Text with custom style
    /**
     let style = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
     style.alignment = .center
     let attributes = [
        NSFontAttributeName: font,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color,
     ]
     imageWithWatermark(text: text, point: point, attributes: attributes)
     */
    public func imageWithWatermark(text: String,
                                   point: CGPoint,
                                   attributes: [String : Any]?) -> UIImage {
        p_setUpImageContext()
        
        (text as NSString).draw(at: point, withAttributes: attributes)
        
        let r = p_imageFromContext()
        
        p_tearDownImageContext()
        
        return r
    }
    
    private func p_setUpImageContext() {
        let rectCanvas = CGRect(origin: CGPoint.zero, size: base.size)
        UIGraphicsBeginImageContextWithOptions(rectCanvas.size, false, 0)
        base.draw(in: rectCanvas)
    }
    
    private func p_tearDownImageContext() {
        UIGraphicsEndImageContext()
    }
    
    private func p_imageFromContext() -> UIImage {
        guard let retImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return base
        }
        
        return retImage
    }
}

// MARK: - 微信分享缩略图
public extension CSSwift where Base: UIImage {
    
    public var wechatShareThumbnail: UIImage {
        var scale: CGFloat = 0
        var isNeedCut = false
        var imageSize = CGSize.zero
        let ratio = base.size.width / base.size.height
        
        if ratio > 3 {
            isNeedCut = true
            if base.size.height > 100 {
                scale = 100 / base.size.height
            } else {
                scale = 1
            }
            imageSize = CGSize(width: CGFloat(base.size.height * scale * 3), height: CGFloat(base.size.height * scale))
        } else if ratio < 0.333 {
            isNeedCut = true
            if base.size.width > 100 {
                scale = 100 / base.size.width
            } else {
                scale = 1
            }
            imageSize = CGSize(width: base.size.width * scale, height: base.size.width * scale * 3)
        } else {
            isNeedCut = false
            if ratio > 1 {
                scale = 280 / base.size.width
            } else {
                scale = 280 / base.size.height
            }
            
            if scale > 1 {
                scale = 1
            }
            imageSize = CGSize(width: base.size.width * scale, height: base.size.height * scale)
        }
        
        let image = p_thumbnailWithSize(targetSize: imageSize, isNeedCut: isNeedCut)
        let imageData = UIImageJPEGRepresentation(image, 0.4)
        return UIImage(data: imageData!)!
    }
    
    private func p_thumbnailWithSize(targetSize: CGSize, isNeedCut: Bool) -> UIImage {
        var imageSize = base.size
        let scaleWidth = targetSize.width / imageSize.width
        let scaleHeight = targetSize.height / imageSize.height
        let scale = max(scaleWidth, scaleHeight)
        imageSize = CGSize(width: imageSize.width * scale, height: imageSize.height * scale)
        
        UIGraphicsBeginImageContext(imageSize)
        defer {
            UIGraphicsEndImageContext()
        }
        
        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = .medium
        
        UIGraphicsPushContext(context!)
        
        base.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        
        UIGraphicsPopContext()
        
        let tmpImage = UIGraphicsGetImageFromCurrentImageContext()
        
        if targetSize.width == 0 || targetSize.height == 0 || !isNeedCut {
            return tmpImage!
        }
        
        let thumbRect = CGRect(x: (imageSize.width - targetSize.width) / 2, y: (imageSize.height - targetSize.height) / 2, width: targetSize.width, height: targetSize.height)
        let temp_img = tmpImage?.cgImage?.cropping(to: thumbRect)
        
        return UIImage(cgImage: temp_img!)
    }
    
}
