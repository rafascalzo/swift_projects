//
//  UITextView+BasicTextView.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/7/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import  UIKit
extension UITextView {
    
    func setupBasicTextView(_ text:String,_ font: UIFont,_ fontColor:UIColor,_ color: UIColor) {
        
        self.text = text
        self.font = font
        self.textColor = fontColor
        self.backgroundColor = color
        self.textAlignment = .center
       
    }
}
