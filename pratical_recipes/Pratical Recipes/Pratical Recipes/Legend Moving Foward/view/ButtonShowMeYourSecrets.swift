//
//  ButtonShowMeYourSecrets.swift
//  Pratical Recipes
//
//  Created by rafaeldelegate on 6/30/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class ButtonShowMeYourSecrets: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.setTitle("Reveal secrets", for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont(name: "Avenir-Black", size: 20)
        self.layer.cornerRadius = 15
        self.addTarget(LegendViewController.instanceMethod(for: #selector(LegendViewController().showSecrets(_:))), action: #selector(LegendViewController().showSecrets(_:)), for: UIControl.Event.touchUpInside)
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
