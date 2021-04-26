//
//  LoadingAnimationView.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/7/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import Lottie

class LoadingAnimationView: UIView {
    
    let animatedLogo = AnimationView(name: "loading-galaxy")
    
    struct Constants {
        static let device = UIDevice.current.userInterfaceIdiom
        static let widhtLogo:CGFloat = device == .phone ? 200 : 400
        static let heightLogo:CGFloat = device == .phone ? 200 : 400
        static let widthView:CGFloat = device == .phone ? 100 : 200
        static let heightView:CGFloat = device == .phone ? 100 : 200
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView(){
        
        self.backgroundColor = .clear
        self.addSubview(animatedLogo)
        animatedLogo.frame.size = CGSize(width: Constants.widhtLogo, height: Constants.heightLogo)
        animatedLogo.center = self.center
        animatedLogo.contentMode = .scaleAspectFit
        animatedLogo.loopMode = LottieLoopMode.loop
        
    }
    
    func setConstraints(_ xParent:UIView){
        
        centerAnchor(xAnchor: xParent.centerXAnchor, yAnchor: xParent.centerYAnchor, size: .init(width: Constants.widthView, height: Constants.heightView))
    }
    
}
