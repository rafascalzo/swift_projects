//
//  Animations.swift
//  animations_and_transitions
//
//  Created by RVSM on 01/03/20.
//  Copyright © 2020 RVSM. All rights reserved.
//

import UIKit
import SpriteKit

public enum AnimationOptions: Int {
    
    case imageTopHeaderBodyTransition = 1
}


public class Animations: NSObject {
    
    public static var standard = Animations()
    
    var transitions: Transitions {
        return Transitions()
    }
    
    public static func bounce() {
        
    }
    
    public static func shake(_ textField: UITextField) {
        let shake = CABasicAnimation(keyPath: "position")
        
        let initialPosition = CGPoint(x: textField.center.x + 5, y: textField.center.y)
        let endPosition = CGPoint(x: textField.center.x - 5, y: textField.center.y)
        shake.fromValue = initialPosition
        shake.toValue = endPosition
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        textField.layer.add(shake, forKey: "shake")
    }
    
    public static func pulse(_ view: UIView) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.fromValue = 0.95
        pulse.toValue = 1
        pulse.duration = 0.5
        pulse.initialVelocity = 0.5
        // damping 1 to 10
        pulse.damping = 1.0
        pulse.autoreverses = true
        
        view.layer.add(pulse, forKey: "pulse")
    }
    
    override init() {}
}

public class Transitions: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration: TimeInterval {
        get {
            return TimeInterval(UINavigationController.hideShowBarDuration)
        }
    }
    var image: UIImage?
    var initialFrame: CGRect!
    var pushing = true
    
    var options: AnimationOptions!
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch options {
        case .imageTopHeaderBodyTransition:
            imageScreen(using: transitionContext)
        case .none:
            break
        @unknown default:
            //
            break
        }
    }
    
    fileprivate func imageScreen(using transitionContext: UIViewControllerContextTransitioning) {
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
        guard initialFrame != nil else { return }
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
    
    public override init() {}
}
