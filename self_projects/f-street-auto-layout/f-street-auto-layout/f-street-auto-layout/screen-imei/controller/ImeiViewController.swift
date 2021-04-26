//
//  ImeiViewController.swift
//  f-street-auto-layout
//
//  Created by Rafael on 6/5/19.
//  Copyright © 2019 Rafael. All rights reserved.
//


import UIKit

class ImeiViewController: UIViewController {

    @IBAction func buttonGenerateImei(_ sender: UIButton) {
    }
    
    @IBOutlet weak var buttonGenerateImei: UIButton!
    
    @IBAction func buttonVerifyAndContinue(_ sender: UIButton) {
    }
    
    @IBOutlet weak var buttonVerifyAndContinue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
//        buttonGenerateImei.layer.cornerRadius = 15
       // buttonVerifyAndContinue.layer.cornerRadius = 15
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.navigationBar.barTintColor = .black
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
