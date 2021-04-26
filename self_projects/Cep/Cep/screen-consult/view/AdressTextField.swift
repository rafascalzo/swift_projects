//
//  AdressTextField.swift
//  Cep
//
//  Created by rafaeldelegate on 6/23/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class AdressTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = HexToUIColor().hexStringToUIColor(hex: "D1F8FF")
        self.keyboardType = .alphabet
        self.placeholder = "Endereço"
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
