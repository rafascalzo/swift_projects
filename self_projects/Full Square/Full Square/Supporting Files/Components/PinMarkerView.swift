//
//  PinMakerView.swift
//  Full Square
//
//  Created by rafaeldelegate on 8/8/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import MapKit

@available(iOS 11.0, *)

class PinMarkerView: MKMarkerAnnotationView {
    
    let imageWidth = 100
    let height = 100
    
    var views = [String:UIView]()
    
    override var annotation: MKAnnotation? {
        
        willSet {
            
            guard let pin = newValue as? Pin else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            
            let buttonPinMenu = UIButton(frame: CGRect(origin: CGPoint.zero,size: CGSize(width: 30, height: 30)))
            buttonPinMenu.addCenterImage(named: "menu1", withMargin: 3, backgroundColor: .whiteColor, size: .init(width: 30, height: 30))
            buttonPinMenu.accessibilityIdentifier = pin.name
            buttonPinMenu.addTarget(MainViewController.self.instanceMethod(for: #selector(MainViewController().showDetails(_:))), action: #selector(MainViewController().showDetails(_:)), for: .touchUpInside)
            rightCalloutAccessoryView = buttonPinMenu
            
            let buttonLike = UIButton(frame: CGRect(origin: CGPoint.zero,size: CGSize(width: 30, height: 30)))
            buttonLike.addCenterImage(named: "white-thumbs-up", withMargin: 3, backgroundColor: .whiteColor, size: .init(width: 30, height: 30))
            buttonLike.backgroundColor = .blueColor
            buttonLike.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
            buttonLike.layer.cornerRadius = 15
            buttonLike.addTarget(MainViewController.self.instanceMethod(for: #selector(MainViewController().handleTap)), action: #selector(MainViewController().handleTap), for: .touchUpInside)
            leftCalloutAccessoryView = buttonLike
            
            glyphTintColor = .black
            //glyphText = String(pin.discipline.first!)
            
            if let imageName = pin.category {
                glyphImage = UIImage(named: imageName)
            } else {
                glyphImage = nil
            }
            
            let snapshotView = UIView()
            
            views = ["snapshotView": snapshotView]
            
            snapshotView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[snapshotView(\(imageWidth))]", options: [], metrics: nil, views: views))
            snapshotView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[snapshotView(\(height))]", options: [], metrics: nil, views: views))
            
            let options = MKMapSnapshotter.Options()
            options.size = CGSize(width: imageWidth, height: height)
            options.mapType = .satelliteFlyover
            //    options.camera = MKMapCamera(lookingAtCenter: self.annotation!.coordinate, fromDistance: 250, pitch: 65, heading: 0)
            
            let snapshotter = MKMapSnapshotter(options: options)
            snapshotter.start { snapshot, error in
                if snapshot != nil {
                    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.imageWidth, height: self.height))
                    if let data = pin.image as Data? {
                        imageView.layer.masksToBounds = true
                        imageView.image = UIImage(data: data as Data)
                        imageView.contentMode = .scaleAspectFill
                    } else {
                        imageView.image = snapshot?.image
                        imageView.contentMode = .scaleAspectFill
                    }
                    snapshotView.addSubview(imageView)
                }
            }
            detailCalloutAccessoryView = snapshotView
        }
    }
}

//func configureDetailView(annotationView: MKAnnotationView) {
//    
//    let width = 300
//    let height = 200
//    
//    let snapshotView = UIView()
//    let views = ["snapshotView": snapshotView]
//    snapshotView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[snapshotView(300)]", options: [], metrics: nil, views: views))
//    snapshotView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[snapshotView(200)]", options: [], metrics: nil, views: views))
//    
//    let options = MKMapSnapshotter.Options()
//    options.size = CGSize(width: width, height: height)
//    options.mapType = .satelliteFlyover
//    options.camera = MKMapCamera(lookingAtCenter: annotationView.annotation!.coordinate, fromDistance: 250, pitch: 65, heading: 0)
//    
//    let snapshotter = MKMapSnapshotter(options: options)
//    snapshotter.start { snapshot, error in
//        if snapshot != nil {
//            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
//            imageView.image = snapshot!.image
//            snapshotView.addSubview(imageView)
//        }
//    }
//    annotationView.detailCalloutAccessoryView = snapshotView
//}
//

