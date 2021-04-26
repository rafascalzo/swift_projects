//
//  Common.swift
//  Viper Geocode
//
//  Created by rafaeldelegate on 8/10/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class Common: NSObject {
    
    class func generateDataList() -> [[String: String]] {
        return [["name": "Orange","vitamin": "Vitain C"],["name": "Watermelon","vitamin": "Vitain A"], ["name": "Banana","vitamin": "Vitain B6"], ["name": "Apple","vitamin": "Vitain C"]]
    }
    
    class func getPinList() -> [[String:Any]]? {
        let pinMarkerArray = PinDAO().retrievePins()
        var pinList : [[String:Any]] = [[:]]
        if pinMarkerArray.count > 0 {
            
            for i in 0...pinMarkerArray.count - 1 {
                let title = String(describing: pinMarkerArray[i].title)
                let location = String(describing: pinMarkerArray[i].location)
                let discipline = String(describing: pinMarkerArray[i].discipline)
                let longitude = pinMarkerArray[i].longitude
                let latitude = pinMarkerArray[i].latitude
                let pin:[String:Any] = ["title":title,"location":location,"discipline":discipline,"latitude":latitude,"longitude":longitude]
                pinList.append(pin)
            }
            return pinList
        }
        return nil
    }
    
}
