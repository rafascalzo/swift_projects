//
//  ViewModifier.swift
//  YSpace
//
//  Created by RVSM on 10/05/20.
//  Copyright © 2020 RVSM. All rights reserved.
//

import UIKit

protocol ViewModifier {

    associatedtype View: UIView
    var borderRadius: CGFloat { get set }
}

extension ViewModifier where Self: UIView {
    
    func border(_ width: CGFloat?) -> CGFloat {
        if width != nil {
            self.layer.borderWidth = width!
        }
        return self.layer.borderWidth
    }
}
