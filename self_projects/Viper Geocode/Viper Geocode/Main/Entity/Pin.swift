//
//  Pin.swift
//  Viper Geocode
//
//  Created by rafaeldelegate on 8/10/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import MapKit

class Pin: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    let latitude : Double
    let longitude : Double
    
    init(title: String, locationName: String, discipline: String, latitude : Double, longitude:Double) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.latitude = latitude
        self.longitude = longitude
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        super.init()
    }
    
    var subtitle: String? { return locationName }
    
    var imageName: String? {
        // cash bicycle burger
        if discipline == "Job" { return "linkedin" }
        if discipline == "Cinema" { return "cinema" }
        if discipline == "Money" { return "cash" }
        if discipline == "Bike" { return "bicycle" }
        if discipline == "Burguer" { return "burger" }
        
        return "forbidden"
    }
    
    var markerTintColor: UIColor  {
        switch discipline {
        case "Job":
            return .lightGray
        case "Cinema":
            return .cyan
        case "Money":
            return .blue
        case "Bike":
            return .purple
        case "Burguer":
            return .red
        default:
            return .green
        }
    }
}
