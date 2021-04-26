//
//  UILabel.swift
//  Cosmo City
//
//  Created by rafael-estagio on 05/07/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    
    func setupBasicLabel(_ text:String?,_ font:UIFont = UIFont.systemFont(ofSize: 13) ,_ textColor:UIColor = .black) -> UILabel {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.numberOfLines = 0
        self.textAlignment = .center
        return self
    }
}
