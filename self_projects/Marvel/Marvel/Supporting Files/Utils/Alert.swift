//
//  Alert.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/11/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    let view = UIView()
    
    let controller:UIViewController
    
    init(controller:UIViewController){
        self.controller = controller
    }
    
    func show(_ tittle: String = "Sorry", message: String = "Unexpected error", completion: @escaping () -> Void){
        
        let alert = UIAlertController(title: "Sorry", message: message, preferredStyle: UIAlertController.Style.alert)
        //let ok = UIAlertAction(title: "Understood", style: UIAlertAction.Style.cancel, handler: nil)
        let ok = UIAlertAction(title: "Understood", style: UIAlertAction.Style.cancel) { (action) in
            
        }
        alert.addAction(ok)
        controller.present(alert, animated: true) {
            
            //            alert.view.superview?.isUserInteractionEnabled = true
            //            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: ViewController.instanceMethod(for: #selector(ViewController.dismissPage(_:))), action: #selector(ViewController().dismissPage(_:))))
            
        }
    }
    
    @objc func alertControllerBackgroundTapped()
    { 
        //  self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
