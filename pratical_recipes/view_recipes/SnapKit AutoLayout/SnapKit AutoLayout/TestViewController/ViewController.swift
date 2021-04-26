//
//  ViewController.swift
//  SnapKit AutoLayout
//
//  Created by rafael-estagio on 08/07/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

class ViewController: UIViewController {
    lazy var box = UIView()
    
    let twitterButton = AnimatedButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupView()
        
        /// Create a button.
        
        twitterButton.translatesAutoresizingMaskIntoConstraints = false
        /// Set an animation on the button.
        twitterButton.animation = Animation.named("stop-go-radio-button")
        /// Turn off clips to bounds, as the animation goes outside of the bounds.
        twitterButton.clipsToBounds = false
        /// Set animation play ranges for touch states
        twitterButton.setPlayRange(fromMarker: "touchDownStart", toMarker: "touchDownEnd", event: .touchDown)
        twitterButton.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpCancel", event: .touchUpOutside)
        twitterButton.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpEnd", event: .touchUpInside)
        view.addSubview(twitterButton)
        twitterButton.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(40)
            make.bottom.equalTo(view)
            make.width.equalTo(self.view.frame.width - 150)
            make.height.equalTo(100)
            make.centerX.equalTo(self.view)
        }
        
        view.addSubview(box)
        box.backgroundColor = .black
        box.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self.view.frame.width - 150)
            make.height.equalTo(150)
            make.topMargin.equalTo(150)
            make.centerX.equalTo(self.view)
            
        }
    }
    
    fileprivate func setupNavigation(){
        if let navigation = navigationController{
            navigation.isNavigationBarHidden = true
        }
    }
    
    fileprivate func setupView(){
        view.backgroundColor = .orange
    }
    
    fileprivate func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    


}

