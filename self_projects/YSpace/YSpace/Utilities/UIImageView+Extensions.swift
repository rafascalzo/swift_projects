//
//  UIImageView+Extensions.swift
//  YSpace
//
//  Created by RVSM on 22/03/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

import UIKit

extension UIImageView {
    
    convenience init(autoLayout: Bool) {
        self.init()
        if autoLayout {
            translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
