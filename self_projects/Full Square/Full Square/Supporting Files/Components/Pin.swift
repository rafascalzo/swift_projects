//
//  Pin.swift
//  Full Square
//
//  Created by rafaeldelegate on 8/6/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import MapKit

class Pin: NSObject, MKAnnotation {
    
    let title: String?
    let name: String?
    let category : String?
    let site: String
    let telephone : String
    let coordinate: CLLocationCoordinate2D
    var image : NSData?
    var icon: UIImage?
    var color: UIColor?
    
    init(name: String,site: String,telephone : String,discipline: String, coordinate: CLLocationCoordinate2D,_ image: NSData?) {
        
        self.title = name
        self.category = discipline
        self.site = site
        self.telephone = telephone
        self.coordinate = coordinate
        self.color = .red
        self.image = image
        self.name = name
        super.init()
    }

    var subtitle: String? { return name }
    var photo : NSData? {return image}
    var imageName: String? {
        // cash bicycle burger
//        if discipline == "Job" { return "linkedin" }
//        if discipline == "Cinema" { return "cinema" }
//        if discipline == "Money" { return "cash" }
//        if discipline == "Bike" { return "bicycle" }
//        if discipline == "Burguer" { return "burger" }
        return category
    }
    
    var markerTintColor: UIColor  {
//        switch discipline {
//        case "Job":
//            return .lightGray
//        case "Cinema":
//            return .cyan
//        case "Money":
//            return .blue
//        case "Bike":
//            return .purple
//        case "Burguer":
//            return .red
//        default:
//            return .green
//        }
        return .red
    }
}
