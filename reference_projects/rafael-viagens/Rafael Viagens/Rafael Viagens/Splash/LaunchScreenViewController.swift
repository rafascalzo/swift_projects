//
//  LaunchScreenViewController.swift
//  Rafael Viagens
//
//  Created by FulltrackMobile on 29/02/20.
//  Copyright © 2020 rafael-estagio. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var constraintTopTitle: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        startAnimation()
        // Do any additional setup after loading the view.
    }
    
    func startAnimation() {
        constraintTopTitle.constant = 280
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            self.goToHome()
        }
        
    }
    
    func goToHome() {
        let tabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigation-controller")
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
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
