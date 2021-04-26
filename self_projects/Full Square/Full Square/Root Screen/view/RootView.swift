//
//  RootView.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 30/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit
import Lottie

class RootView: UIView {

    var delegate : RootViewDelegate?
    
    var gradientLayer : CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0,0.5,1]
        return gradientLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        backgroundColor = .blackColor
        
        let darkTextLabel : UILabel = {
            let label = UILabel()
            label.text = "Full Square"
            label.textColor = UIColor(white: 1, alpha: 0.2)
            label.font = UIFont.tittleExtraLargeFont
            label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 400)
            label.textAlignment = .center
            return label
        }()
        
        let shinyTextLabel : UILabel = {
            let label = UILabel()
            label.text = "Full Square"
            label.textColor = .white
            label.font = UIFont.tittleExtraLargeFont
            label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 400)
            label.textAlignment = .center
            return label
        }()
        
        addSubview(shinyTextLabel)
        
        addSubview(darkTextLabel)
        
        gradientLayer.frame = shinyTextLabel.frame
        
        let angle = 45 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        shinyTextLabel.layer.mask = gradientLayer
        
        // animation
        let animationFind = AnimationView(name: "find-location")
        
        addSubview(animationFind)
        
        animationFind.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(300)
        }
        animationFind.loopMode = .loop
        animationFind.play()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
