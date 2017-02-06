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
     UIImage init from an URL string
     
     - parameter urlString: URL string
     
     - returns: UIImage
     */
    public convenience init(urlString: String) {
        let imageData = NSData(contentsOf: NSURL(string: urlString) as! URL)
        self.init(data: imageData as! Data)!
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

// MARK: - save
public extension CSSwift where Base: UIImage {
    
    /**
     Save UIImage to file
     
     - parameter filePath:          file path
     - parameter compressionFactor: compression factor, only useful for JPEG format image.
     
     - returns: true or false
     */
    public func saveImageToFile(filePath: String, compressionFactor: CGFloat) -> Bool {
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
        
        return self.imageCropped(bounds: rectRatioed)
    }
    
    /**
     Mirror UIImage
     
     - returns: UIImage mirrored
     */
    public var imageMirrored: UIImage {
        let width = base.size.width
        let height = base.size.height
        
        UIGraphicsBeginImageContext(base.size)
        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = .high
        
        context?.translateBy(x: width, y: height)
        context?.concatenate(CGAffineTransform(scaleX: -1.0, y: -1.0))
        context?.draw(base.cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let imageRef = context!.makeImage()
        let resultImage = UIImage(cgImage: imageRef!)
        UIGraphicsEndImageContext()
        
        return resultImage
    }
    
    /**
     Rotate UIImage to specified degress
     
     - parameter degress: degress to rotate
     
     - returns: UIImage rotated
     */
    public func imageRotatedByDegrees(degrees: CGFloat) -> UIImage {
        let radians = CGFloat(M_PI) * degrees / 180.0
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height))
        rotatedViewBox.transform = CGAffineTransform(rotationAngle: radians)
        
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create bitmap context.
        UIGraphicsBeginImageContext(rotatedSize)
        let context = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and.
        context?.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)
        
        // Rotate the image context
        context?.rotate(by: radians)
        
        // Now, draw the rotated/scaled image into the context
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.draw(base.cgImage!, in: CGRect(x: -base.size.width / 2.0, y: -base.size.height / 2.0, width: base.size.width, height: base.size.height))
        
        let imageRotated = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageRotated!
    }
    
    /**
     Scale UIImage to specified size.
     
     - parameter targetSize:        targetSize
     - parameter withOriginalRatio: whether the result UIImage should keep the original ratio
     
     - returns: UIImage scaled
     */
    public func imageScaledToSize(targetSize: CGSize, withOriginalRatio: Bool) -> UIImage {
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
        base.draw(in: CGRect(x: 0, y: 0, width: sizeFinal.width, height: sizeFinal.height))
        let imageScaled: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return imageScaled
    }
    
    /**
     UIImage with corner radius without Off-Screen Rendering.
     Much better than setting layer.cornerRadius and layer.masksToBounds.
     
     - parameter cornerRadius: corner radius
     
     - returns: UIImage
     */
    public func imageWithCornerRadius(cornerRadius: CGFloat) -> UIImage {
        let frame = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height)
        
        UIGraphicsBeginImageContext(base.size)
        
        // Add a clip before drawing anything, in the shape of an rounded rect
        UIBezierPath(roundedRect: frame, cornerRadius: cornerRadius).addClip()
        
        // Draw the image
        base.draw(in: frame)
        
        let imageWithCornerRadius = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return imageWithCornerRadius!
    }
    
    public var imageWithNormalOrientation: UIImage {
        if base.imageOrientation == UIImageOrientation.up {
            return base
        }
        
        UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
        base.draw(in: CGRect(origin: CGPoint.zero, size: base.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
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
        
        let image = self.thumbnailWithSize(targetSize: imageSize, isNeedCut: isNeedCut)
        let imageData = UIImageJPEGRepresentation(image, 0.4)
        return UIImage(data: imageData!)!
    }
    
    private func thumbnailWithSize(targetSize: CGSize, isNeedCut: Bool) -> UIImage {
        var imageSize = base.size
        let scaleWidth = targetSize.width / imageSize.width
        let scaleHeight = targetSize.height / imageSize.height
        let scale = max(scaleWidth, scaleHeight)
        imageSize = CGSize(width: imageSize.width * scale, height: imageSize.height * scale)
        
        UIGraphicsBeginImageContext(imageSize)
        
        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = .medium
        
        UIGraphicsPushContext(context!)
        
        base.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        
        UIGraphicsPopContext()
        
        let tmpImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        if targetSize.width == 0 || targetSize.height == 0 || !isNeedCut {
            return tmpImage!
        }
        
        let thumbRect = CGRect(x: (imageSize.width - targetSize.width) / 2, y: (imageSize.height - targetSize.height) / 2, width: targetSize.width, height: targetSize.height)
        let temp_img = tmpImage?.cgImage?.cropping(to: thumbRect)
        
        return UIImage(cgImage: temp_img!)
    }
    
}
