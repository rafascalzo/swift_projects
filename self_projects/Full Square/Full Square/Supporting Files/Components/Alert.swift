//
//  Alert.swift
//  Full Square
//
//  Created by macbook-estagio on 02/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

enum AlertCaseOption {
    case cancel
    case confirm
}

import Foundation
import UIKit

class Alert {
    
    let controller : UIViewController
    
    init(controller:UIViewController){
        self.controller = controller
    }
    
    func showOkOption(_ tittle: String = "Sorry", message: String = "Unexpected error", completion: (() -> Void)?){
        
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { UIAlertAction in
            NSLog("%@ vou concatenar esse teste", "Ok pressionado. Eu")
            completion?()
        })
        alert.addAction(okAction)
        
        controller.present(alert, animated: true) {
        }
    }
    
    func showOkWithCancelOption(_ tittle: String = "Sorry", message: String = "Unexpected error", completion: @escaping (_ option : AlertCaseOption) -> Void){
        
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { UIAlertAction in
            NSLog("%@ vou concatenar esse teste", "Ok pressionado. Eu")
            completion(.confirm)
        })
        alert.addAction(okAction)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in
            NSLog(String(format: "%.2f", 3.14159265359))
            completion(.cancel)
        })
        alert.addAction(cancel)
        controller.present(alert, animated: true) {
        }
    }
}
