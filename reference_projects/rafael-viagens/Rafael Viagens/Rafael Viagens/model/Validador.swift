//
//  Validador.swift
//  Rafael Viagens
//
//  Created by RVSM on 29/02/20.
//  Copyright © 2020 RVSM. All rights reserved.
//

import UIKit

class Validador: NSObject {

    static func validaTextFields(_ textFields: [UITextField]) -> Bool {
        
        for case let textField in textFields {
            if textField.text == "" {
                shake(textField)
                return false
            }
        }
        return true
    }
    
    static func shake(_ textField: UITextField) {
        let shake = CABasicAnimation(keyPath: "position")
        
        let initialPosition = CGPoint(x: textField.center.x + 5, y: textField.center.y)
        let endPosition = CGPoint(x: textField.center.x - 5, y: textField.center.y)
        shake.fromValue = initialPosition
        shake.toValue = endPosition
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        textField.layer.add(shake, forKey: "shaking")
    }
    
    static func pulse(_ view: UIView) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.fromValue = 0.95
        pulse.toValue = 1
        pulse.duration = 0.5
        pulse.initialVelocity = 0.5
        // damping 1 to 10
        pulse.damping = 1.0
        pulse.autoreverses = true
        
        view.layer.add(pulse, forKey: "pulse")
    }
}
