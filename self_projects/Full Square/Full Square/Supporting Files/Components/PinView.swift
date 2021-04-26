//
//  PinView.swift
//  Full Square
//
//  Created by rafaeldelegate on 8/8/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class PinView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let pin = newValue as? Pin else {return}
            
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            
            accessibilityLabel = pin.title
            //rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "menu1"), for: UIControl.State())
            rightCalloutAccessoryView = mapsButton
            if let imageName = pin.category {
                let resizedImage:UIImage = UIImage().resizeImage(named: imageName, width: 50, height: 50)
                image = resizedImage
            } else {
                image = nil
            }

            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = pin.subtitle
            detailLabel.textAlignment = .center
            detailLabel.sizeThatFits(CGSize(width: self.frame.width, height: 20))
            detailCalloutAccessoryView = detailLabel
        }
    }
}
