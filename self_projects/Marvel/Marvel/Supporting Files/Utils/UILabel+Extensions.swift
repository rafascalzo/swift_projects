//
//  UILabel+Extensions.swift
//  Marvel
//
//  Created by rafael-estagio on 22/07/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func setBasicLabel(text:String? = nil, textColor: UIColor? = .black,font:UIFont? = UIFont.systemFont(ofSize: 15), backgroundColor:UIColor? = .white, textAlignment : NSTextAlignment? = .center){
        
        if let text = text {
            let localizedText = NSLocalizedString(text, comment: "")
            self.text = localizedText
        }
        if let textColor = textColor{
            self.textColor = textColor
        }
        if let font = font{
            self.font = font
        }
        if let backgroundColor = backgroundColor{
            self.backgroundColor = backgroundColor
        }
        if let textAlignment = textAlignment{
            self.textAlignment = textAlignment
        }
        self.sizeToFit()
    }
    
}
