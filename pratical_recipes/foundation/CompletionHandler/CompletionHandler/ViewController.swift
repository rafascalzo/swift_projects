//
//  ViewController.swift
//  CompletionHandler
//
//  Created by rafaeldelegate on 6/27/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Service.grabDataFromDatabase { (result) in
            print("Result = \(result!)")
        }
    }
    
    


}

