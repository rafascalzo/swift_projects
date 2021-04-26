//
//  TextFieldCep.swift
//  Cep
//
//  Created by rafaeldelegate on 6/27/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class TextFieldCep: UITextField {
    
    let textLabel = "Cep:"
    let fontLabel = "Avenir-Regular"
    let fontSizeLabel:CGFloat = 16
    let fontColorLabel = "000000"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isEnabled = true
        self.backgroundColor = HexToUIColor().hexStringToUIColor(hex: "EAECEB")
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
