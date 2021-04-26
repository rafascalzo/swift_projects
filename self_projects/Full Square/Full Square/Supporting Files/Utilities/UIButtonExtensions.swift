//
//  UIButtonExtensions.swift
//  Full Square
//
//  Created by macbook-estagio on 31/07/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func setupTaggedImageButton(named name: String, tag:Int, backGroundColor: UIColor, withRadius radius: CGFloat, margin: CGFloat, size : CGSize){
        self.tag = tag
        layer.cornerRadius = radius
        self.backgroundColor = backGroundColor
        let img = UIImage.resize(image: UIImage(named: name)!, targetSize: size)
        self.setImage(img, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func addCenterImage(named name: String?, withMargin margin: CGFloat?, backgroundColor: UIColor, size: CGSize){
        
        if let name = name {
            let img = UIImage.resize(image: UIImage(named: name)!, targetSize: size)
            setImage(img, for: .normal)
        }
        
        if let margin = margin {
            self.imageEdgeInsets = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        }
        self.backgroundColor = backgroundColor
    }
    
}
