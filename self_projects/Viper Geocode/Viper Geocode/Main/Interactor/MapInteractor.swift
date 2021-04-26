//
//  MapInteractor.swift
//  Viper Geocode
//
//  Created by rafaeldelegate on 8/10/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//
// It has the business logic specified by a use case.

// Map module’s business logic and handlings
import UIKit

class MapInteractor: MapInputInteractorProtocol { 

    weak var presenter: MapOutputInteractorProtocol?
    
    func getPinList() {
        presenter?.pinListDidFetch(pinList: getAllPinsDetail())
    }
    func setupMapConfiguration(){
        presenter?.setupMapConfiguration()
    }
    func getAllPinsDetail() -> [Pin] {
        
        var pinList = [Pin]()
        
        guard let allPins = Common.getPinList() else {return []}
        
        if allPins.count > 0 {
            for index in 0...allPins.count - 1 {
                let title = allPins[index]["title"] as! String
                let locationName = allPins[index]["location"] as! String
                let discipline = allPins[index]["discipline"] as! String
                let latitude = (allPins[index]["latitude"] as! NSString).doubleValue
                let longitude = (allPins[index]["longitude"] as! NSString).doubleValue
                let pin = Pin(title: title , locationName: locationName, discipline: discipline, latitude: latitude, longitude : longitude)
                pinList.append(pin)
            }
        }
        return pinList
    }
}
