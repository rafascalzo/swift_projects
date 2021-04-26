//
//  CitySearchBar.swift
//  Cep
//
//  Created by rafaeldelegate on 6/23/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class CitySearchBar: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.searchBarStyle = UISearchBar.Style.prominent
        self.placeholder = "Cidade"
        self.sizeToFit()
        self.isTranslucent = false
        self.autoresizesSubviews = true
        self.clearsContextBeforeDrawing = true
        self.isOpaque = true
        //self.barTintColor = HexToUIColor().hexStringToUIColor(hex: "4A60E2")
        //self.backgroundColor = HexToUIColor().hexStringToUIColor(hex: "4A60E2")
        //self.barStyle = .default
        self.searchBarStyle = .minimal
         // UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: HexToUIColor().hexStringToUIColor(hex: "AACDA7")]
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
