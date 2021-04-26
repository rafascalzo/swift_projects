//
//  LogoViewController.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/3/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class LogoViewController: UIViewController {
    
    let logo = LogoAnimatedView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupView()
        startControllerTransition()
    }
    
    fileprivate func setupNavigation(){
        guard let navigation = navigationController else  {return}
        navigation.isNavigationBarHidden = true
    }
    
    fileprivate func startControllerTransition(){
        if let navigation = navigationController {
            animateControllerTransition(navigation)
        }
    }
    
    fileprivate func setupView() {
        
        view.backgroundColor = .backgroundColor
        view.addSubview(logo)
        
        logo.center = self.view.center
        logo.animatedLogo.play()
    }
    
    fileprivate func animateControllerTransition(_ navigation: UINavigationController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                self.view.alpha = 0
            }, completion: { (_) in
                navigation.pushViewController(SpaceViewController(), animated: true)
            })
        }
    }
    
}
