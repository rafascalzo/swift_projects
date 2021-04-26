//
//  ProgressCircleBarViewController.swift
//  Pratical Recipes
//
//  Created by rafaeldelegate on 6/29/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class CircularProgressBarViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigation = navigationController{
            navigation.navigationBar.barStyle = .black
            navigation.isNavigationBarHidden = true
        }
        
        setupLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    var circularProgressBar = CircleProgressBar(layer: CALayer.init())
    var trackLayer = TrackLayer(layer: CALayer.init())
    var pulsatingLayer = PulsatingLayer(layer: CALayer.init())
    var countingLabel = CountingLabel()
    
    func setupLayout(){
        view.backgroundColor = UIColor.backgroudColor
       
        countingLabel.frame = self.view.frame
        pulsatingLayer.position = view.center
        view.layer.addSublayer(pulsatingLayer)
        trackLayer.position = view.center
        view.layer.addSublayer(trackLayer)
        circularProgressBar.position = view.center
        view.layer.addSublayer(circularProgressBar)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateLayer)))
        
         view.addSubview(countingLabel)
    }
    
    var displayLink : CADisplayLink?
    
    @objc func animateLayer(){
        print("attempt to animate stroke")
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 5
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        circularProgressBar.add(basicAnimation, forKey: "urSoBasic")
        displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink!.add(to: .main, forMode: .default)
        
        animationStartDate = Date()
        
    }
    
    private func animatePulsingLayer(){
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.3
        animation.duration = 0.8
        animation.autoreverses = true
        //animation.repeatCount = Float.infinity
        animation.repeatCount = 7
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
    var startValue:Double = 0
    let endValue:Double = 100
    let animationDuration:Double = 5
    var animationStartDate:Date?
    
    @objc func handleUpdate(){
         print(Date())
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate!)
        
        if elapsedTime > animationDuration {
            self.countingLabel.text = String(format: "%.f", endValue) + " %"
            self.displayLink?.isPaused.toggle()
            animatePulsingLayer()
        } else {
            let percentage = elapsedTime / animationDuration
            let value = startValue + percentage*(endValue - startValue)
            self.countingLabel.text = String(format: "%.f", value) + " %"
           }

//        self.countingLabel.text = "\(startValue)"
//        startValue += 1
//
//        if startValue > endValue {
//        startValue=endValue
//        }
//
//                let seconds = Date().timeIntervalSince1970
//                self.countingLabel.text = "\(seconds)"
        
    }
    
}
