//
//  UITextField+BasicTextField.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/17/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
    func setBasics(text:String?, font:UIFont?,textColor:UIColor? ,allignment:NSTextAlignment?, _ backgroundColor:UIColor?, isEditable editable:Bool, withInteraction interaction:Bool) -> Void {
        
        if let text = text {
            let localizedText = NSLocalizedString(text, comment: "")
            self.text = localizedText
        }
        if let font = font{
            self.font = font
        }
        if let textColor = textColor{
            self.textColor = textColor
        }
        if let allignment = allignment {
            textAlignment = allignment
        }
        if let color = backgroundColor{
            self.backgroundColor = color
        }
        isEditable = editable
        isUserInteractionEnabled = interaction
        
        sizeToFit()
    }
}
