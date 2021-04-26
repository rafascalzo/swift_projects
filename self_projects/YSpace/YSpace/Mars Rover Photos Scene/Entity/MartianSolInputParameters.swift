//
//  QueryingByMartianSol.swift
//  YSpace
//
//  Created by RVSM on 29/03/20.
//  Copyright © 2020 RVSM. All rights reserved.
//

import Foundation
/*
sol    int    none    sol (ranges from 0 to max found in endpoint)
camera    string    all    see table above for abbreviations
page    int    1    25 items per page returned
api_key    string    DEMO_KEY    api.nasa.gov key for expanded usage
*/

struct MartianSolInputParameters: Codable {
    
    var authenticated: Bool
    var sol: Int?
    var camera: String?
    var page: Int
    
    private enum CodingKeys: String, CodingKey {
        case authenticated
        case sol = "sol"
        case camera = "camera"
        case page = "page"
    }
}
