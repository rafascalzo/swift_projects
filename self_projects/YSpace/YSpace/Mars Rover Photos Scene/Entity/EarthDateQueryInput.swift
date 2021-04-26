//
//  EarthDateQueryInput.swift
//  YSpace
//
//  Created by RVSM on 25/03/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

import Foundation

struct MarsEarthDateQueryingParameters: Codable {
    
    var authenticated: Bool
    var rover: String
    var earthDate: String
    var camera: String
    var page: Int
    
    private enum CodingKeys: String, CodingKey {
        
        case authenticated, rover
        case earthDate = "earth_date"
        case camera = "camera"
        case page = "page"
    }
}
