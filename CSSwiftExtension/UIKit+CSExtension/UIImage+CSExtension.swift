//
//  UIImage+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

// MARK: - UIImage

public extension UIImage {
    
    /**
     UIImage init from an URL string
     
     - parameter urlString: URL string
     
     - returns: UIImage
     */
    public convenience init(urlString: String) {
        let imageData = NSData(contentsOfURL: NSURL(string: urlString)!)
        self.init(data: imageData!)!
    }
    
    /**
     UIImage init from pure color
     
     - parameter pureColor: pure color
     - parameter size:      size
     
     - returns: UIImage
     */
    public convenience init(pureColor: UIColor, size: CGSize) {
        let rect = CGRectMake(0, 0, size.width, size.height)
        
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, pureColor.CGColor)
        CGContextFillRect(context, rect)
        let imageWithPureColor: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageData = UIImagePNGRepresentation(imageWithPureColor)
        self.init(data: imageData!)!
    }
    
}


// MARK: - 

public extension UIImage {
    
    /**
     Save UIImage to file
     
     - parameter filePath:          file path
     - parameter compressionFactor: compression factor, only useful for JPEG format image.
     
     - returns: true or false
     */
    func cs_saveImageToFile(filePath: String, compressionFactor: CGFloat) -> Bool {
        let imageData: NSData!
        if filePath.hasSuffix(".jpeg") {
            imageData = UIImageJPEGRepresentation(self, compressionFactor)
        } else {
            imageData = UIImagePNGRepresentation(self)!
        }
        
        if NSFileManager.defaultManager().fileExistsAtPath(filePath) {
            do {
                try NSFileManager.defaultManager().removeItemAtPath(filePath)
            } catch {
                print("This file (\(filePath)) exists already, and NSFileManager failed to remove it.")
                return false
            }
        }
        
        if NSFileManager.defaultManager().createFileAtPath(filePath, contents: imageData, attributes: nil) {
            return imageData.writeToFile(filePath, atomically: true)
        } else {
            print("NSFileManager failed to create file at path: \(filePath).")
            return false
        }
    }
    
    //////////////////////////////////////////////////
    
    /**
     Scale UIImage to specified size.
     
     - parameter size:              specified size
     - parameter withOriginalRatio: whether the result UIImage should keep the original ratio
     
     - returns: UIImage scaled
     */
    func cs_imageScaledToSize(size: CGSize, withOriginalRatio: Bool) -> UIImage {
        var sizeFinal = size
        
        if withOriginalRatio {
            let ratioOriginal = self.size.width / self.size.height
            let ratioTemp = size.width / size.height
            
            if ratioOriginal < ratioTemp {
                sizeFinal.width = size.height * ratioOriginal
            } else if ratioOriginal > ratioTemp {
                sizeFinal.height = size.width / ratioOriginal
            }
        }
        
        UIGraphicsBeginImageContext(sizeFinal)
        self.drawInRect(CGRectMake(0, 0, sizeFinal.width, sizeFinal.height))
        let imageScaled: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageScaled
    }
    
    /**
     Rotate UIImage to specified degress
     
     - parameter degress: degress to rotate
     
     - returns: UIImage rotated
     */
    func cs_imageRotatedByDegrees(degrees: CGFloat) -> UIImage {
        let radians = CGFloat(M_PI) * degrees / 180.0
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRectMake(0, 0, self.size.width, self.size.height))
        rotatedViewBox.transform = CGAffineTransformMakeRotation(radians)
        
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create bitmap context.
        UIGraphicsBeginImageContext(rotatedSize)
        let context = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and.
        CGContextTranslateCTM(context, rotatedSize.width / 2.0, rotatedSize.height / 2.0)
        
        // Rotate the image context
        CGContextRotateCTM(context, radians)
        
        // Now, draw the rotated/scaled image into the context
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextDrawImage(context, CGRectMake(-self.size.width / 2.0, -self.size.height / 2.0, self.size.width, self.size.height), self.CGImage)
        
        let imageRotated = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageRotated
    }
    
    /**
     UIImage with corner radius without Off-Screen Rendering.
     Much better than setting layer.cornerRadius and layer.masksToBounds.
     
     - parameter cornerRadius: corner radius
     
     - returns: UIImage
     */
    func cs_imageWithCornerRadius(cornerRadius: CGFloat) -> UIImage {
        let frame = CGRectMake(0, 0, self.size.width, self.size.height)
        
        UIGraphicsBeginImageContext(self.size)
        
        // Add a clip before drawing anything, in the shape of an rounded rect
        UIBezierPath(roundedRect: frame, cornerRadius: cornerRadius).addClip()
        
        // Draw the image
        self.drawInRect(frame)
        
        let imageWithCornerRadius = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return imageWithCornerRadius
    }
    
}