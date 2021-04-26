//
//  GuitarYeahImageView.swift
//  Pratical Recipes
//
//  Created by rafaeldelegate on 6/28/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class AngusYoungImageView: UIImageView {
    
    let imageName = "electric-guitar-angus"
    let height:CGFloat = 25
    let width:CGFloat = 25
    
    var topAnchorConstraint : NSLayoutConstraint?
    var leftAnchorConstraint : NSLayoutConstraint?
    var rightAnchorConstraint : NSLayoutConstraint?
    var bottomAnchorConstraint : NSLayoutConstraint?
    var heightConstraint : NSLayoutConstraint?
    var widthConstraint : NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = UIImage(named: imageName)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints(topParent:UIView = UIView(), leftParent:UIView = UIView(), rightParent: UIView = UIView(), bottomParent:UIView = UIView()){
        
        topAnchorConstraint = self.topAnchor.constraint(equalTo: topParent.safeAreaLayoutGuide.topAnchor)
        topAnchorConstraint?.isActive = true
        
        leftAnchorConstraint = self.leftAnchor.constraint(equalTo: leftParent.safeAreaLayoutGuide.leftAnchor)
        leftAnchorConstraint?.isActive = true
        
        rightAnchorConstraint = self.rightAnchor.constraint(equalTo: rightParent.safeAreaLayoutGuide.rightAnchor)
        rightAnchorConstraint?.isActive = false
        
        bottomAnchorConstraint = self.bottomAnchor.constraint(equalTo: bottomParent.safeAreaLayoutGuide.bottomAnchor)
        bottomAnchorConstraint?.isActive = false
        
        heightConstraint = self.heightAnchor.constraint(equalToConstant: height)
        heightConstraint?.isActive = true
        
        widthConstraint =  self.widthAnchor.constraint(equalToConstant: width)
        widthConstraint?.isActive = true
        
    }
    
    func AnimationHandleToCorners(view:UIView){
        
        topAnchorConstraint?.isActive = !topAnchorConstraint!.isActive
        bottomAnchorConstraint?.isActive = !bottomAnchorConstraint!.isActive
        leftAnchorConstraint?.isActive = !leftAnchorConstraint!.isActive
        rightAnchorConstraint?.isActive = !rightAnchorConstraint!.isActive
        
        rightAnchorConstraint?.constant = -16
        bottomAnchorConstraint?.constant = -16
        
        heightConstraint?.constant = 75
        widthConstraint?.constant = 75
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
}
