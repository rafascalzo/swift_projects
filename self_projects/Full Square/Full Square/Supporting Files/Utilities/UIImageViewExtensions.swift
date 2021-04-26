//
//  UIImageViewExtensions.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 14/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func addCenterImageView(named name:String, with size:CGSize)  {
        layer.masksToBounds = true
        image = UIImage(named: name)
        accessibilityIdentifier = name
        image = UIImageView.scaleImageToSize(image: image!, size: size)
    }
    
    func pixelateImage() -> UIImage?{
        guard let currentCGImage = self.image?.cgImage else { return nil}
        let currentCIImage = CIImage(cgImage: currentCGImage)
        
        let filter = CIFilter(name: "CIPixellate")
        filter?.setValue(currentCIImage, forKey: kCIInputImageKey)
        filter?.setValue(1, forKey: kCIInputScaleKey)
        guard let outputImage = filter?.outputImage else { return nil }
        
        let context = CIContext()
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            return processedImage
        }
        
        return nil
    }
    
    class func scaleImageToSize(image: UIImage, size : CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
}
