//
//  iconsContainerView.swift
//  Pratical Recipes
//
//  Created by rafael-estagio on 01/07/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class IconsContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        let iconHeight:CGFloat = 50
        let padding:CGFloat = 8
        let iconWidth:CGFloat = 50
        
//        let arrangedSubviews =  [UIColor.red,.blue,.orange,.green,.yellow].map { (color) -> UIView in
//
//            let view = UIView()
//            view.backgroundColor = color
//            view.layer.cornerRadius = iconHeight / 2
//            return view
//        }
        
        let images = ["electric-guitar-angus","electric-guitar-yeah","eletric-guitar-riffing","electric-guitar-crash","eletric-guitar-the-who"]
        
        let arrangedSubviews = images.map { (imageName) -> UIView in
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.layer.cornerRadius = iconHeight / 2
            // required for hit testing
            imageView.isUserInteractionEnabled = true
            return imageView
        }
        
        let arrangedSubviewsSize = CGFloat(arrangedSubviews.count)
        
        self.frame = CGRect(x: 0, y: 0, width: (arrangedSubviewsSize * iconWidth) + (padding * (arrangedSubviewsSize + 1)), height: iconHeight + (2 * padding))
        self.layer.cornerRadius = self.frame.height / 2
        
        // shadow
        self.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 0.4)
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.frame = self.frame
        self.addSubview(stackView)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
