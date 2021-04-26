//
//  FacebookLiveViewController.swift
//  Pratical Recipes
//
//  Created by Fulltrack Mobile on 05/09/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

//
//  NewViewController.swift
//  Full Square
//
//  Created by rafaeldelegate on 9/5/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit

class FacebookLiveViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        //
        //        let curvedView = CurvedView(frame: view.frame)
        //        curvedView.backgroundColor = .purple
        //        view.addSubview(curvedView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        
    }
    @objc func handleTap(){
        (0...10).forEach { (_) in
            generateAnimationViews()
        }
    }
    fileprivate func generateAnimationViews(){
        let images = ["white-thumbs-up","white-heart"]
        let imageName :String = images.randomElement()!
        let image = UIImage(named: imageName)
        image?.accessibilityIdentifier = imageName
        
        let dimension = 20 + drand48() + 10
        let imageView = UIButton()
        
        imageView.setImage(image, for: .normal)
        imageView.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = image?.accessibilityIdentifier == "white-heart" ? .red : .blue
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        imageView.layer.add(animation, forKey: nil)
        
        view.addSubview(imageView)
    }
}


class CurvedView: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = customPath()
        path.lineWidth = 3
        path.stroke()
    }
}

func customPath() -> UIBezierPath {
    let path = UIBezierPath()
    
    path.move(to: CGPoint(x: 0, y: 200))
    
    let endPoint = CGPoint(x: 400, y: 200)
    
    let randomYShift = 200 + drand48() * 300
    
    let cp1 = CGPoint(x: 100, y: 100 - randomYShift)
    let cp2 = CGPoint(x: 200, y: 400 + randomYShift)
    
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}


