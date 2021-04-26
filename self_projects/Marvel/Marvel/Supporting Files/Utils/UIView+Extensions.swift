//
//  UIView+LayerConfig.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/17/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    
    func setColoredLightLayer(_ color:UIColor) -> Void {
        alpha = 0.35
        backgroundColor = color
        
        layer.shadowRadius = 0.1
        layer.shadowOpacity = 0.7
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 1, height: -2)
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.075
    }
    
    func setColoredBorders(color : UIColor){
        
        layer.masksToBounds = true
        layer.borderColor = color.cgColor
        layer.borderWidth = 2.5
        
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowRadius = 1.1
        layer.shadowOpacity = 0.8
        layer.shadowOffset.height = -0.5
        layer.cornerRadius = 3
    }
    func setColoredLightBorders(color:UIColor){
        
        layer.masksToBounds = true
        layer.borderColor = color.cgColor
        layer.borderWidth = 0.5
        
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowRadius = 1.1
        layer.shadowOpacity = 0.8
        layer.shadowOffset.height = -0.5
        layer.cornerRadius = 3
    }
    
    func setCircularView(radius: CGFloat){
        self.layer.cornerRadius = radius
    }
    
    func addCellBlur(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
    static let blurEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blur = UIVisualEffectView(effect: blurEffect)
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blur
    }()
    
    func addBlur(){
        UIView.blurEffectView.frame = self.bounds
        addSubview(.blurEffectView)
    }
    func removeBlur() {
        UIView.blurEffectView.frame = .zero
        UIView.blurEffectView.removeFromSuperview()
    }
    
}


