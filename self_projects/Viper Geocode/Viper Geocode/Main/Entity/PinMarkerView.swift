//
//  PinMarkerView.swift
//  Viper Geocode
//
//  Created by rafaeldelegate on 8/10/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import MapKit

class PinMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let pin = newValue as? Pin else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            // 2
            markerTintColor = pin.markerTintColor
            // glyphText = String(artwork.discipline.first!)
            if let imageName = pin.imageName {
                glyphImage = UIImage(named: imageName)
            } else {
                glyphImage = nil
            }
        }
    }
    
}
