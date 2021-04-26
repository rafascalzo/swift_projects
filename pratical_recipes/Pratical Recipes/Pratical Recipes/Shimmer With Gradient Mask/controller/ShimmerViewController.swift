//
//  ShimmerViewController.swift
//  Pratical Recipes
//
//  Created by rafaeldelegate on 7/2/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class ShimmerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigation = navigationController{
            navigation.isNavigationBarHidden = true
        }
        
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        
        
        let darkTextLabel : UILabel = {
           let label = UILabel()
            label.text = "Shimmer"
            label.textColor = UIColor(white: 1, alpha: 0.2)
            label.font = UIFont.systemFont(ofSize: 80)
            label.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400)
            label.textAlignment = .center
            return label
        }()
        
        let shinyTextLabel : UILabel = {
            let label = UILabel()
            label.text = "Shimmer"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 80)
            label.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400)
            label.textAlignment = .center
            return label
        }()
        
        view.addSubview(shinyTextLabel)
        
        view.addSubview(darkTextLabel)
        
        // pretty easy if you know the code to draw a gradient
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0,0.5,1]
        gradientLayer.frame = shinyTextLabel.frame
        
        let angle = 45 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        shinyTextLabel.layer.mask = gradientLayer
        
        // animation
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -view.frame.width
        animation.toValue = view.frame.width
        animation.repeatCount = Float.infinity
        animation.duration = 4
        
        gradientLayer.add(animation, forKey: "a chave de casa que esqueci no banco outro dia")
        
        //view.layer.addSublayer(gradientLayer)
    }

}
