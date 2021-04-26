//
//  WheaterViewController.swift
//  Wheater
//
//  Created by rafaeldelegate on 7/3/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class WheaterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let navigation = navigationController else {"Não deu mano";return}
        
        navigation.isNavigationBarHidden = true
        
        view.backgroundColor = .blue
        WheaterApi().getData { (resposta) in
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    

}
