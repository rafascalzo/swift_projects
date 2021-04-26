//
//  CircleProgressBar.swift
//  Pratical Recipes
//
//  Created by rafaeldelegate on 6/29/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class CircleProgressBar: CAShapeLayer  {
    
    let radius:CGFloat = 100
    let startAngle:CGFloat = 0
    let endAngle:CGFloat = 2 * CGFloat.pi
    
    override init(layer: Any) {
        super.init(layer: layer)
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius , startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        self.path = circularPath.cgPath
        self.strokeColor = UIColor.outlineStrokeColor.cgColor
        self.lineWidth = 20
             self.fillColor = UIColor.clear.cgColor
        self.strokeEnd = 0
        self.lineCap = CAShapeLayerLineCap.round
        self.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
