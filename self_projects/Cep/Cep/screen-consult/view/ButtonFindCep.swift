//
//  FindCepButton.swift
//  Cep
//
//  Created by rafaeldelegate on 6/24/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class ButtonFindCep: UIButton {
    
    let colorBlueESCURO = "4a60e2"
    let colorWhite = "ffffff"
    let colorBlueCLARO = "EAECEB"

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setButtonAutoLayout("Buscar Cep", "Avenir-Black", 25, colorBlueCLARO, colorBlueESCURO, cornerRadius: 15)
    
        self.addTarget(CepViewController.self.instanceMethod(for: #selector(CepViewController().findCep(_:))), action: #selector(CepViewController().findCep(_:)), for: .touchUpInside)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
