//
//  UIButton+Extensions.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/23/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func setupCornedButton(title:String?, font:UIFont?, cornerRadius:CGFloat?) -> Void {
        
        if let title = title {
            let localizedTitle = NSLocalizedString(title, comment: "")
            setTitle(localizedTitle, for: .normal)
        }
        if let font = font {
            titleLabel?.font = font
        }
        if let cornerRadius = cornerRadius{
            layer.cornerRadius = cornerRadius
        }
        
    }
    
    func setupCircularImagedButton(named name:String, radius:CGFloat){
        layer.cornerRadius = radius
        setImage(UIImage(named: name), for: .normal)
        layer.masksToBounds = true
    }
}
