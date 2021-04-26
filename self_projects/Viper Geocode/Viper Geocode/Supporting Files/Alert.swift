//
//  Alert.swift
//  Viper Geocode
//
//  Created by rafaeldelegate on 8/10/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    let view = UIView()
    
    let controller : UIViewController
    
    init(controller:UIViewController){
        self.controller = controller
    }
    
    func show(_ tittle: String = "Sorry", message: String = "Unexpected error", completion: @escaping () -> ()){
        
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel) { (action) in
            
        }
        alert.addAction(ok)
        controller.present(alert, animated: true) {
            completion()
        }
    }
}
