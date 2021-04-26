//
//  LabelStreet.swift
//  Cep
//
//  Created by rafaeldelegate on 6/27/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class LabelDistrict: UILabel {

    let textLabel = "Bairro:"
    let fontLabel = "Avenir-Black"
    let fontSizeLabel:CGFloat = 16
    let fontColorLabel = "000000"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLabelAutoLayout(textLabel, fontLabel, fontSizeLabel, fontColorLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
