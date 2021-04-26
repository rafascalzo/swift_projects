//
//  AnimationView+Extensions.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/23/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit
import Lottie

extension AnimationView {
    
    func setupAnimation(named animationName:String?, withSpeed speed:CGFloat?, loopMode:LottieLoopMode?, size:CGSize?) -> Void {
        
        if let animationName = animationName{
            animation = Animation.named(animationName)
        }
        if let speed = speed{
            animationSpeed = speed
        }
        if let loopMode = loopMode {
            self.loopMode = loopMode
        }
        if let size = size{
            frame.size = size
        }
        contentMode = .scaleAspectFit
        //backgroundColor = .clear
    }
}
