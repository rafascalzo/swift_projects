//
//  StackViewBody.swift
//  Cep
//
//  Created by rafaeldelegate on 6/27/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class StackViewBody: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
            self.translatesAutoresizingMaskIntoConstraints = false
            self.axis = .vertical
            self.spacing = 6
            self.distribution = UIStackView.Distribution.equalCentering
            self.contentMode = .center
            self.alignment = UIStackView.Alignment.center
            self.isLayoutMarginsRelativeArrangement = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
