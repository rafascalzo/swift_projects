//
//  ViewController.swift
//  animations_and_transitions
//
//  Created by RVSM on 29/02/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

class MainView: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var firstView: UIView!
    
    // MARK: - IBActions
    @IBAction func startAnimation(_ sender: Any) {
        animateOptions()
    }
    
    fileprivate func animateByFrame() {
        //        UIView.animate(withDuration: 1) {
        //            self.firstView.frame = CGRect(x: 285, y: self.firstView.frame.origin.y, width: self.firstView.frame.size.width, height: self.firstView.frame.size.height)
        //        }
        
        UIView.animate(withDuration: 1, animations: {
            self.firstView.frame = CGRect(x: 285, y: self.firstView.frame.origin.y, width: self.firstView.frame.size.width, height: self.firstView.frame.size.height)
        }) { _ in
            UIView.animate(withDuration: 1) {
                self.firstView.frame = CGRect(x: 45, y: self.firstView.frame.origin.y, width: self.firstView.frame.size.width, height: self.firstView.frame.size.height)
            }
        }
    }
    
    fileprivate func animateOptions() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse, .curveEaseIn], animations: {
            self.firstView.frame = CGRect(x: self.firstView.frame.origin.x, y: 580, width: self.firstView.frame.size.width, height: self.firstView.frame.size.height)
        }) { _ in
            //
        }
    }
    
    fileprivate func animateByTransform() {
        UIView.animate(withDuration: 2) { [weak self] in
            self?.firstView.transform = CGAffineTransform(translationX: 0, y: 30)
        }
    }
    
    fileprivate func flash() {
        let animation = CABasicAnimation()
        animation.keyPath = "opacity"
        animation.duration = 5
        //animation.fillMode = .forwards
        animation.fromValue = 0
        animation.toValue = 1
        firstView.layer.add(animation, forKey: "my key")
    }
    
    fileprivate func changeColor() {
        let animations = CABasicAnimation(keyPath: "backgroundColor")
        animations.duration = 5
        animations.fromValue = UIColor.red.cgColor
        animations.toValue = UIColor.blue.cgColor
        
        firstView.layer.add(animations, forKey: "color_change")
    }
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

