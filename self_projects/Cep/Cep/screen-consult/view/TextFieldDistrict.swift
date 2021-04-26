//
//  TextFieldDistrict.swift
//  Cep
//
//  Created by rafaeldelegate on 6/27/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class TextFieldDistrict: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isEnabled = false
        self.textAlignment = .center
        self.backgroundColor = HexToUIColor().hexStringToUIColor(hex: "EAECEB")
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
