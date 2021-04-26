//
//  FacebookPopUpViewController.swift
//  Pratical Recipes
//
//  Created by rafael-estagio on 01/07/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class FacebookPopUpViewController: UIViewController {
    
    var iconsContainerView = IconsContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigation = navigationController{
            navigation.isNavigationBarHidden = true
        }
        
        setupView()
        setupLongPressGesture()
    }
    
    func setupLongPressGesture(){
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer){
        //print("harehooo", Date())
        if (gesture.state == .began) {
            
            handleGestureBegan(gesture: gesture)
            
        }else if gesture.state == .ended{
            
            //clean up animation
          
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                let stackView = self.iconsContainerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity

                })
                
            }) { (_) in
                self.iconsContainerView.removeFromSuperview()
            }
            
            
        } else if gesture.state == .changed {
            handleGestureChanged(gesture: gesture)
            
        }
    }
    fileprivate func handleGestureChanged(gesture: UILongPressGestureRecognizer){
        let pressedLocation = gesture.location(in: self.iconsContainerView)
        print(pressedLocation)
        
       let hitTestView = iconsContainerView.hitTest(pressedLocation, with: nil)
        
        if hitTestView is UIImageView {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let stackView = self.iconsContainerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                
                hitTestView?.transform = CGAffineTransform(translationX: 0, y: -62)
            })
        }
        
    }
    
    fileprivate func handleGestureBegan(gesture: UILongPressGestureRecognizer){
        
        view.addSubview(iconsContainerView)
        
        let pressedLocation = gesture.location(in: view)
        print(pressedLocation)
        
        //transformation of the box
        let centeredX = (view.frame.width - iconsContainerView.frame.width)/2
        iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y)
        
        //alpha
        iconsContainerView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y - self.iconsContainerView.frame.height)
            self.iconsContainerView.alpha = 1
            
        })
        
        
    }
    
    fileprivate func setupView(){
        
        view.backgroundColor = .facebookBackgroundColor
      }
    
    
    
    
}
