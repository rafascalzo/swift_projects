//
//  ImeiViewController.swift
//  FStreet
//
//  Created by Rafael on 6/5/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit

class ImeiViewController: UIViewController {

    @IBAction func buttonGeneratImei(_ sender: UIButton) {
    }
    @IBOutlet weak var buttonGenerateImei: UIButton!
    
    @IBAction func buttonVerifyAndContinue(_ sender: UIButton) {
    }
    
    @IBOutlet weak var buttonVerifyAndContinue: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        buttonGenerateImei.layer.cornerRadius = 15
        buttonVerifyAndContinue.layer.cornerRadius = 15
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
      
     //navigationController?.isNavigationBarHidden = true
       // navigationController?.isToolbarHidden = true;
        
      // navigationController?.setNavigationBarHidden(true, animated: true)
       // navigationController?.navigationBar.backgroundColor = .white
        //self.navigationController?.navigationBar.tintColor = .red
        //self.navigationItem.titleView?.backgroundColor = .red
        //self.navigationItem.titleView?.tintColor = .red
       // tabBarController?.tabBar.barTintColor = UIColor.brown
        //tabBarController?.tabBar.tintColor = UIColor.yellow
        //navigationController?.navigationBar.barTintColor = UIColor.black
     // self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: (self.navigationController?.navigationBar.frame.size.width)!, height: 116)
       
       // navigationController?.navigationBar.prefersLargeTitles = false
       }
    
    /*override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }*/

    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
