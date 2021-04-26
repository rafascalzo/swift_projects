//
//  UISearchbar+UFSearchBar.swift
//  Cep
//
//  Created by rafaeldelegate on 6/23/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class UFSearchBar: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.placeholder = "Estado"
        self.sizeToFit()
        self.isTranslucent = false
        self.searchBarStyle = .minimal
      //  UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: HexToUIColor().hexStringToUIColor(hex: "D1F8FF")]
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

