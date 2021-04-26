//
//  CountingLabel.swift
//  Pratical Recipes
//
//  Created by rafaeldelegate on 6/29/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class CountingLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.text = "Start"
        self.textAlignment = .center
        self.font = .countingLabelFont
        self.textColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
}
