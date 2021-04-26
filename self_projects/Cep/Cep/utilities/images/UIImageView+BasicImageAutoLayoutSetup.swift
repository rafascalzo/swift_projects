//
//  UIImage+BasicImageAutoLayoutSetup.swift
//  f-street
//
//  Created by rafael-estagio on 19/06/19.
//  Copyright © 2019 Fulltime. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setaBasicAutoLayoutImage(_ imageName:String) -> UIImageView {
        let imageView = self
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
