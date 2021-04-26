//
//  UITextView+Extensions.swift
//  YSpace
//
//  Created by RVSM on 22/03/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

import UIKit

extension UITextView {
    
    convenience init(autoLayout: Bool = false) {
        self.init()
        if autoLayout {
            translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
