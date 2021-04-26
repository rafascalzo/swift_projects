//
//  Localization.swift
//  Full Square
//
//  Created by rafaeldelegate on 8/4/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import CoreLocation

class Localization : NSObject {
    
    func convertAdressToCoordinates(_ adress : String, completion: @escaping(_ local : CLPlacemark) -> Void){
        let conversor = CLGeocoder()
        conversor.geocodeAddressString(adress) { (locationList, error) in
            if let location = locationList?.first {
                completion(location)
            }
        }
    }
}
