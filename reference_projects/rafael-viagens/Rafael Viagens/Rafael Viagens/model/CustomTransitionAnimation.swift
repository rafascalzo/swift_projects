//
//  CustromTransitionAnimation.swift
//  Rafael Viagens
//
//  Created by RVSM on 29/02/20.
//  Copyright © 2020 RVSM. All rights reserved.
//

import UIKit

class CustomTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var duration: TimeInterval
    private var image: UIImage
    private var initialFrame: CGRect
    private var pushing: Bool
    
    init(_ duration: TimeInterval, _ image: UIImage, _ initialFrame: CGRect, _ pushing: Bool) {
        self.duration = duration
        self.image = image
        self.initialFrame = initialFrame
        self.pushing = pushing
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let initialView = transitionContext.view(forKey: .from) else { return }
        guard let endView = transitionContext.view(forKey: .to) else { return }
        let context = transitionContext.containerView
        if pushing {
            context.addSubview(endView)
        } else {
            context.insertSubview(endView, belowSubview: initialView)
        }
        
        let currentView = pushing ? endView : initialView
        
        currentView.frame = pushing ? CGRect(x: initialView.frame.width, y: 0, width: endView.frame.width, height: endView.frame.height) :
        initialView.frame
        currentView.layoutIfNeeded()
        
        guard let imageView = currentView.viewWithTag(1) as? UIImageView else { print("caguei"); return}
        imageView.image = image
        
        let transitionImage = UIImageView(frame: initialFrame)
        transitionImage.image = image
        
        context.addSubview(transitionImage)
        
        UIView.animate(withDuration: duration, animations: {
            transitionImage.frame = self.pushing ? imageView.frame : self.initialFrame
            currentView.frame = self.pushing ? initialView.frame : CGRect(x: initialView.frame.width, y: 0, width: endView.frame.width, height: endView.frame.height)
        }) { _ in
            transitionImage.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
    }
}
