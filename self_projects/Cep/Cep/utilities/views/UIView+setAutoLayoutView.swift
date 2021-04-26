//
//  UIView+setAutoLayoutView.swift
//  f-street
//
//  Created by rafael-estagio on 19/06/19.
//  Copyright © 2019 Fulltime. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func setAutoLayoutView (_ backgroundColorHex:String = "FFFFFF") -> UIView{
        
        self.backgroundColor = HexToUIColor().hexStringToUIColor(hex: backgroundColorHex)
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setConstraintLayout(parentTop : UIView = UIView() , constantTop : CGFloat = 0, parentBot : UIView = UIView() , constantBot : CGFloat = 0, parentLeft : UIView = UIView(), constantLeft : CGFloat = 0, parentRight : UIView = UIView(), constantRight : CGFloat = 0){
        
        if parentTop.bounds == UIScreen.main.bounds{
            
            self.topAnchor.constraint(equalTo: parentTop.topAnchor, constant: constantTop).isActive = true
        } else{
            self.topAnchor.constraint(equalTo: parentTop.bottomAnchor, constant: constantTop).isActive = true
        }
        
        if parentBot.bounds == UIScreen.main.bounds {
            self.bottomAnchor.constraint(equalTo: parentBot.bottomAnchor, constant: constantBot).isActive = true
        }else{
            self.bottomAnchor.constraint(equalTo: parentBot.topAnchor, constant: constantBot).isActive = true
        }
        
        if parentRight.bounds == UIScreen.main.bounds {
            self.rightAnchor.constraint(equalTo: parentRight.rightAnchor, constant: -constantRight).isActive = true
        }else{
            self.rightAnchor.constraint(equalTo: parentRight.leftAnchor, constant: -constantRight).isActive = true
        }
       
        if parentLeft.bounds == UIScreen.main.bounds {
            self.leftAnchor.constraint(equalTo: parentLeft.leftAnchor, constant: constantTop).isActive = true
        }else{
            self.leftAnchor.constraint(equalTo: parentLeft.rightAnchor, constant: constantTop).isActive = true
        }
    }
    
    func setConstraintLayoutCenter(parentX : UIView = UIView(), parentY : UIView = UIView()){
        self.centerXAnchor.constraint(equalTo: parentX.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: parentY.centerYAnchor).isActive = true
        }
    
    func setConstraintLayoutSizes(parentHeight : UIView = UIView(), constantHeight : CGFloat = 0, parentWidth : UIView = UIView() , constantWidth : CGFloat = 0){
        self.widthAnchor.constraint(equalTo: parentWidth.widthAnchor, constant: constantWidth).isActive = true
        self.heightAnchor.constraint(equalTo: parentHeight.heightAnchor, constant: constantHeight).isActive = true
    }
    
}
