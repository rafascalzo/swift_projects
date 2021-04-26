//
//  UILabel+TitleLabel.swift
//  Cep
//
//  Created by rafaeldelegate on 6/23/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLabelAutoLayout("CEP BRASIL", "Avenir-Black", 27, "EAECEB")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
