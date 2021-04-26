//
//  LottieViewController.swift
//  Pratical Recipes
//
//  Created by rafael-estagio on 03/07/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import Lottie

class LottieViewController: UIViewController {
    
  
    let starAnimationView = AnimationView(name: "swiftkey-logo")
    let button = Button()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let navigation = navigationController else {print("N deu mano");return}
        
        navigation.isNavigationBarHidden = true
        
        button.isHidden = true
        view.addSubview(button)
        button.setupConstraints(bottomParent: view, centerXParent: view)
        button.alpha = 0
        self.view.addSubview(self.starAnimationView)
        
        self.starAnimationView.frame = self.view.frame
        self.starAnimationView.play {(finished) in}
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                self.starAnimationView.alpha = 0
            }, completion: { (_) in
                UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    
                    self.button.isHidden = false
                    self.button.alpha = 1
                }, completion: nil)
            })
            }
    }
    
    @objc func playAnimation(_ sender: UIButton){
        
        print("trying to animate :D")
        self.button.alpha = 0
        self.starAnimationView.alpha = 1
        self.starAnimationView.play {(finished) in
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                self.starAnimationView.alpha = 0
            }, completion: { (_) in
                UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    
                    self.button.isHidden = false
                    self.button.alpha = 1
                }, completion: nil)
            })
            
            
        }
    }
}
