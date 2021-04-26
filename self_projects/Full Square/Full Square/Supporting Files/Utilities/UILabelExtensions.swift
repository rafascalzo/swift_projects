//
//  UILabelExtensions.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 22/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setBasic(_ title: String?,_ font: UIFont? = UIFont.boldSystemFont(ofSize: 12),_ textColor: UIColor? = .black,_ allignment: NSTextAlignment? = .center) -> Void {
        
        if let title = title {
            text = title
        }
        if let font = font {
            self.font = font
        }
        if let textColor = textColor {
            self.textColor = textColor
        }
        if let allignment = allignment {
            textAlignment = allignment
        }
    }
}
