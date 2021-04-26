//
//  ViewController.swift
//  Pratical Recipes
//
//  Created by rafaeldelegate on 6/28/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class MoveToCornersViewController: UIViewController {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigation = navigationController{
            navigation.navigationBar.barStyle = .black
            navigation.isNavigationBarHidden = true
        }
        
        setupLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }

    var angusYoungImageView = AngusYoungImageView(frame: CGRect.init())

    func setupLayout(){
        view.backgroundColor = .white
        view.addSubview(angusYoungImageView)
        angusYoungImageView.setConstraints(topParent: self.view, leftParent: self.view, rightParent: self.view, bottomParent: self.view)
        angusYoungImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAnimate)))
    }
    
    @objc func handleAnimate(){
     print("Trying to animate to the other corner")
        angusYoungImageView.AnimationHandleToCorners(view: self.view)
       }
    
   
}

