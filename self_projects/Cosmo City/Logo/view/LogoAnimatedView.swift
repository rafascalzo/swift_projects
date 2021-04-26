//
//  LogoAnimatedView.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/3/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit
import Lottie

final class LogoAnimatedView : UIView {
    
    let animatedLogo = AnimationView(name: "world-locations")
    
    struct Constants {
        static let device = UIDevice.current.userInterfaceIdiom
        static let widhtLogo:CGFloat = device == .phone ? 500 : 1000
        static let heightLogo:CGFloat = device == .phone ? 500 : 1000
        static let widthView:CGFloat = device == .phone ? 100 : 200
        static let heightView:CGFloat = device == .phone ? 100 : 200
    }
    
    let viewAnimated = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAutoLayoutView()
        setupView()
        }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.addSubview(animatedLogo)
        animatedLogo.frame.size = CGSize(width: Constants.widhtLogo, height: Constants.heightLogo)
        animatedLogo.center = self.center
        animatedLogo.contentMode = .scaleAspectFit
        
    }
    
    func setConstraints(_ xParent:UIView){
        
       centerAnchor(xAnchor: xParent.centerXAnchor, yAnchor: xParent.centerYAnchor, size: .init(width: Constants.widthView, height: Constants.heightView))
        }
    
}

extension UIView {
    
     func setupAutoLayoutView (){
        
        translatesAutoresizingMaskIntoConstraints = false
       
    }
}
