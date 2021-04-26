//
//  HeaderView.swift
//  Cep
//
//  Created by rafaeldelegate on 6/24/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class HeaderView: UIView {
 let colorBlueESCURO = "4a60e2"
    let colorBlueMARINHOKKKK = "1572ff"
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setAutoLayoutView(colorBlueESCURO)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
