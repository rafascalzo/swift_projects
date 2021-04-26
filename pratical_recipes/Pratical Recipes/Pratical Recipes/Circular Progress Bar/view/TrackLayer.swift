//
//  TrackLayer.swift
//  Pratical Recipes
//
//  Created by rafaeldelegate on 6/29/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class TrackLayer: CAShapeLayer {
    
    let radius:CGFloat = 100
    let startAngle:CGFloat = 0
    let endAngle:CGFloat = 2 * CGFloat.pi
    
    override init(layer: Any) {
        super.init(layer: layer)
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius , startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        self.path = circularPath.cgPath
        self.strokeColor = UIColor.trackStrokeColor.cgColor
        self.lineWidth = 20
        self.fillColor = UIColor.backgroudColor.cgColor
        
        self.lineCap = CAShapeLayerLineCap.round
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
