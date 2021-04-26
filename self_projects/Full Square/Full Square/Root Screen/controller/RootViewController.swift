//
//  RootViewController.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 29/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit
import Lottie

class RootViewController: UIViewController, RootViewDelegate {
    
    //MARK: - Attributes
    typealias CustomView = RootView

    var customView: CustomView {
        if let view = self.view as? CustomView {
            view.delegate = self
            return view
        } else {
            let view = CustomView()
            view.delegate = self
            self.view = view
            return view
        }
    }

    override func loadView() {
        let customView = CustomView()
        customView.delegate = self
        view = customView
    }

    fileprivate func setupNavigation() {
        if let navigation = navigationController{
            navigation.isNavigationBarHidden = true
        }
    }
    
    fileprivate func animateTitle() {
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -customView.frame.width
        animation.toValue = customView.frame.width
        animation.repeatCount = Float.infinity
        animation.duration = 7
        
        customView.gradientLayer.add(animation, forKey: "a chave de casa que esqueci no banco outro dia")
    }
    
    fileprivate func goTo(controller : UIViewController, after timeInterval: Double) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            UIView.animate(withDuration: 0.5, delay: 0,  options: .curveEaseInOut, animations: {
                self.view.alpha = 0.4
            }, completion: { (_) in
                if let navigation = self.navigationController {
                    navigation.pushViewController(MainViewController(), animated: false)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        animateTitle()
        goTo(controller: MainViewController(), after: 5)
    }
}
