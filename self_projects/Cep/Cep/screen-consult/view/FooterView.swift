//
//  FooterView.swift
//  Cep
//
//  Created by rafaeldelegate on 6/24/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class FooterView: UIView {
    let colorBlue = "4a60e2"
    let colorWhite = "ffffff"

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setAutoLayoutView(colorWhite)
    
        }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraintLayout(parentBot:UIView = UIView(),parentWidth:UIView = UIView(),widthMargins:CGFloat=0, parentTop:UIView, height:CGFloat){
        
       //self.setConstraintLayoutSizes( constantHeight: height, parentWidth: parentWidth, constantWidth: marginsW)
        
        self.topAnchor.constraint(equalTo: parentTop.bottomAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: parentWidth.widthAnchor, constant: widthMargins).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.bottomAnchor.constraint(equalTo: parentBot.layoutMarginsGuide.bottomAnchor).isActive = true
    }
}
