//
//  Logo.swift
//  Cep
//
//  Created by rafaeldelegate on 6/23/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class LogoImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage(named: "brasil")
        self.clipsToBounds = true
        self.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width/3
        self.alpha = 0.32
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
