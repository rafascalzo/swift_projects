//
//  UIStackViewExtensions.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/27/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    
    func setupStackViewRelativeArrangement(axis:NSLayoutConstraint.Axis? = .vertical, distribution:UIStackView.Distribution?, padding:CGFloat){
        
        if let distribution = distribution {
            self.distribution = distribution
        }
        if let axis = axis {
            self.axis = axis
        }
        self.spacing = padding
        self.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        self.isLayoutMarginsRelativeArrangement = true
    }
}
