//
//  button.swift
//  Pratical Recipes
//
//  Created by rafael-estagio on 03/07/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .gray
        self.setTitle("Reanimate", for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont(name: "Avenir-Black", size: 20)
        self.layer.cornerRadius = 15
        self.addTarget(LottieViewController.instanceMethod(for: #selector(LottieViewController().playAnimation(_:))), action: #selector(LottieViewController().playAnimation(_:)), for: UIControl.Event.touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(bottomParent:UIView = UIView(), centerXParent:UIView = UIView()){
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: bottomParent.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            self.centerXAnchor.constraint(equalTo: centerXParent.centerXAnchor),
            self.widthAnchor.constraint(equalToConstant: 300),
            self.heightAnchor.constraint(equalToConstant: 55)])
        
    }
    
}
