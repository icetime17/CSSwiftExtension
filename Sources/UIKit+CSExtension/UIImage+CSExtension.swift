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
        let rect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(pureColor.cgColor)
        context?.fill(rect)
        let imageWithPureColor: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let imageData = UIImagePNGRepresentation(imageWithPureColor)
        self.init(data: imageData!)!
    }
    
}

// MARK: - save
extension UIImage {
    
    /**
     Save UIImage to file
     
     - parameter filePath:          file path
     - parameter compressionFactor: compression factor, only useful for JPEG format image.
     
     - returns: true or false
     */
    public func cs_saveImageToFile(filePath: String, compressionFactor: CGFloat) -> Bool {
        let imageData: NSData!
        if filePath.hasSuffix(".jpeg") {
            imageData = UIImageJPEGRepresentation(self, compressionFactor) as NSData!
        } else {
            imageData = UIImagePNGRepresentation(self)! as NSData!
        }
        
        
        if FileManager.default.fileExists(atPath: filePath) {
            do {
                try FileManager.default.removeItem(atPath: filePath)
            } catch {
                print("This file (\(filePath)) exists already, and NSFileManager failed to remove it.")
                return false
            }
        }
        
        if FileManager.default.createFile(atPath: filePath, contents: imageData as Data?, attributes: nil) {
            return imageData.write(toFile: filePath, atomically: true)
        } else {
            print("FileManager failed to create file at path: \(filePath).")
            return false
        }
    }
    
}

// MARK: - utils
extension UIImage {
    
    /**
     Crop UIImage
     
     - returns: UIImage cropped
     */
    public func cs_imageCropped(bounds: CGRect) -> UIImage {
        let imageRef = cgImage!.cropping(to: bounds)
        let imageCropped = UIImage(cgImage: imageRef!)
        return imageCropped
    }
    
    /**
     Crop UIImage to fit target size
     
     - returns: UIImage cropped
     */
    public func cs_imageCroppedToFit(targetSize: CGSize) -> UIImage {
        var widthImage: CGFloat = 0.0
        var heightImage: CGFloat = 0.0
        var rectRatioed: CGRect!
        
        if size.height / size.width < targetSize.height / targetSize.width {
            // 图片的height过小, 剪裁其width, 而height不变
            heightImage = size.height
            widthImage = heightImage * targetSize.width / targetSize.height
            rectRatioed = CGRect(x: (size.width - widthImage) / 2, y: 0, width: widthImage, height: heightImage)
        } else {
            // 图片的width过小, 剪裁其height, 而width不变
            widthImage = size.width
            heightImage = widthImage * targetSize.height / targetSize.width
            rectRatioed = CGRect(x: 0, y: (size.height - heightImage) / 2, width: widthImage, height: heightImage)
        }
        
        return cs_imageCropped(bounds: rectRatioed)
    }
    
    /**
     Mirror UIImage
     
     - returns: UIImage mirrored
     */
    public func cs_imageMirrored() -> UIImage {
        let width = size.width
        let height = size.height
        
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = .high
        
        context?.translateBy(x: width, y: height)
        context?.concatenate(CGAffineTransform(scaleX: -1.0, y: -1.0))
        context?.draw(cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
        
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
    public func cs_imageRotatedByDegrees(degrees: CGFloat) -> UIImage {
        let radians = CGFloat(M_PI) * degrees / 180.0
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
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
        context?.draw(cgImage!, in: CGRect(x: -self.size.width / 2.0, y: -self.size.height / 2.0, width: size.width, height: size.height))
        
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
    public func cs_imageScaledToSize(targetSize: CGSize, withOriginalRatio: Bool) -> UIImage {
        var sizeFinal = targetSize
        
        if withOriginalRatio {
            let ratioOriginal = size.width / size.height
            let ratioTemp = targetSize.width / targetSize.height
            
            if ratioOriginal < ratioTemp {
                sizeFinal.width = targetSize.height * ratioOriginal
            } else if ratioOriginal > ratioTemp {
                sizeFinal.height = targetSize.width / ratioOriginal
            }
        }
        
        UIGraphicsBeginImageContext(sizeFinal)
        self.draw(in: CGRect(x: 0, y: 0, width: sizeFinal.width, height: sizeFinal.height))
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
    public func cs_imageWithCornerRadius(cornerRadius: CGFloat) -> UIImage {
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContext(size)
        
        // Add a clip before drawing anything, in the shape of an rounded rect
        UIBezierPath(roundedRect: frame, cornerRadius: cornerRadius).addClip()
        
        // Draw the image
        draw(in: frame)
        
        let imageWithCornerRadius = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return imageWithCornerRadius!
    }
    
    public func cs_imageWithNormalOrientation() -> UIImage {
        if imageOrientation == UIImageOrientation.up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage!
    }
    
}

// MARK: - 微信分享缩略图
extension UIImage {
    public func cs_wechatShareThumbnail() -> UIImage {
        var scale: CGFloat = 0
        var isNeedCut = false
        var imageSize = CGSize.zero
        let ratio = size.width / size.height
        
        if ratio > 3 {
            isNeedCut = true
            if size.height > 100 {
                scale = 100 / size.height
            } else {
                scale = 1
            }
            imageSize = CGSize(width: CGFloat(size.height * scale * 3), height: CGFloat(size.height * scale))
        } else if ratio < 0.333 {
            isNeedCut = true
            if size.width > 100 {
                scale = 100 / size.width
            } else {
                scale = 1
            }
            imageSize = CGSize(width: size.width * scale, height: size.width * scale * 3)
        } else {
            isNeedCut = false
            if ratio > 1 {
                scale = 280 / size.width
            } else {
                scale = 280 / size.height
            }
            
            if scale > 1 {
                scale = 1
            }
            imageSize = CGSize(width: size.width * scale, height: size.height * scale)
        }
        
        let image = cs_thumbnailWithSize(targetSize: imageSize, isNeedCut: isNeedCut)
        let imageData = UIImageJPEGRepresentation(image, 0.4)
        return UIImage(data: imageData!)!
    }
    
    private func cs_thumbnailWithSize(targetSize: CGSize, isNeedCut: Bool) -> UIImage {
        var imageSize = size
        let scaleWidth = targetSize.width / imageSize.width
        let scaleHeight = targetSize.height / imageSize.height
        let scale = max(scaleWidth, scaleHeight)
        imageSize = CGSize(width: imageSize.width * scale, height: imageSize.height * scale)
        
        UIGraphicsBeginImageContext(imageSize)
        
        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = .medium
        
        UIGraphicsPushContext(context!)
        
        draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        
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
