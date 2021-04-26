//
//  UITextFieldExtensions.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 28/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func buildSketchWith(tag : Int, text : String?,_ textColor : UIColor?,_ textAlignment :NSTextAlignment?,_ backgroundColor : UIColor?){
        
        self.tag = tag
        
        if let text = text {
            self.text = text
        }
        
        if let textColor = textColor {
          self.textColor = textColor
        }
        
        if let textAlignment = textAlignment{
            self.textAlignment = textAlignment
        }
        
        if  let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }
    func buildSketchWith(tag : Int?, placeholder : String?,_ font : UIFont?,_ textColor : UIColor?,_ textAlignment :NSTextAlignment?,_ backgroundColor : UIColor?){
        
        if let tag = tag {
            self.tag = tag
        }
        
        if let placeholder = placeholder {
            self.placeholder = placeholder
        }
        
        if let textColor = textColor {
            self.textColor = textColor
        }
        
        if let textAlignment = textAlignment{
            self.textAlignment = textAlignment
        }
        
        if  let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }
    
    
    
    func moveCursor(_ offset : Int){
        
        let arbitraryValue: Int = offset

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(integerLiteral: arbitraryValue), height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func addLeftImage(_ img: UIImage, _ color : UIColor?) {
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width * 0.1, height: self.frame.height))
        let centerX: CGFloat = (leftView.frame.midX)
            //- (img.size.width / 2)
        let centerY: CGFloat = (leftView.frame.midY)
            //- (img.size.height / 2)
        
        let leftImageView = UIImageView(frame: CGRect(x: centerX + 7, y: centerY + 10, width: 30, height: 30))
        leftImageView.contentMode = .scaleAspectFit
        
        if let color = color {
            leftImageView.image = img.withRenderingMode(.alwaysTemplate)
            leftImageView.tintColor = color
        } else {
             leftImageView.image = img
        }
        self.addSubview(leftImageView)
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
}
