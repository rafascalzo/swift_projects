//
//  BodyView.swift
//  Cep
//
//  Created by rafaeldelegate on 6/24/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class BodyView: UIView {

    override init(frame: CGRect) {
        
        let colorBlue = "4a60e2"
        let colorWhite = "ffffff"
        super.init(frame: frame)
        self.setAutoLayoutView(colorWhite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
