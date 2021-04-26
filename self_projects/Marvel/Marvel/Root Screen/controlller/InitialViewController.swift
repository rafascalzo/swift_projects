//
//  InitialViewController.swift
//  Marvel
//
//  Created by macbook-estagio on 26/07/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import Lottie
class InitialViewController: UIViewController, RootViewDelegate, HasCustomView {

    typealias CustomView = RootView
    
    var rootView: CustomView {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        pushMainScreen()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
     func setupNavigation() {
        if let navigation = navigationController {
            navigation.isNavigationBarHidden = true
        }
    }
    
    fileprivate func pushMainScreen() {
        if let navigation = navigationController {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut, animations: {
                    self.view.alpha = 0
                }, completion: { (_) in
                    navigation.pushViewController(MainViewController(), animated: true)
                })
            }
        }
    }
}
