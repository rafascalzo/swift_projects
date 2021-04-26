//
//  NASAAPI.Curiosity.swift
//  YSpace
//
//  Created by Rafael VSM on 31/01/20.
//  Copyright © 2020 Rafael VSM. All rights reserved.
//

/*
 name    Name of the Rover
 landing_date    The Rover's landing date on Mars
 launch_date    The Rover's launch date from Earth
 status    The Rover's mission status
 max_sol    The most recent Martian sol from which photos exist
 max_date    The most recent Earth date from which photos exist
 total_photos    Number of photos taken by that Rover
 */

import Foundation
import Alamofire

enum QueryType : String {
    case earthDate = "earth_date", martianSun = "martian_sun"
}

extension NASAAPI {
    
    struct Curiosity {
        
        typealias MarsRoversCompletion = (_ data: MarsRoverPhotos?, _ error: String?) -> Void
        
        static func enqueue(type: RequestType, queryParameters: EncodableObject) {
            
            // save to requestQueue
            if let data = try? JSONEncoder().encode(queryParameters) {
                var queue = Queue()
                let request = Request(type: type.value(), parameters: data)
                queue.push(request)
            } else {
                
            }
        }
        
        static func queryByEarthDate(rover: RoverName, queryParameters: MarsEarthDateQueryingParameters, completion: @escaping MarsRoversCompletion) {
            var url: URLConvertible
            let earth = URLQueryItem(name: "earth_date", value: "2015-6-3")
            let camera = URLQueryItem(name: "camera", value: queryParameters.camera)
            let page = URLQueryItem(name: "page", value: "\(queryParameters.page)")
            let parameters = [earth, camera, page]
            switch rover {
            case .curiosity:
                url = URLComposer.buildURL(baseUrl: .base, from: .marsCuriosity, queryParameters: parameters, apiKey: queryParameters.authenticated)
            case .opportunity:
                url = URLComposer.buildURL(baseUrl: .base, from: .marsOpportunity, queryParameters: parameters, apiKey: queryParameters.authenticated)
            case .spirit:
                url = URLComposer.buildURL(baseUrl: .base, from: .marsSpirit, queryParameters: parameters, apiKey: queryParameters.authenticated)
            }
            print(url)
            NASAAPI.shared.requestObject(url: url, method: .get, nil, encoding: URLEncoding.default, header: .none, completion: completion)
        }
        
        static func queryByMartianSol(rover: RoverName, queryParameters: MartianSolInputParameters, completion: @escaping MarsRoversCompletion) {
            var url: URLConvertible
            var parameters: [URLQueryItem] = []
            
            if let sol = queryParameters.sol {
                parameters.append(URLQueryItem(name: "sol", value: "\(sol)"))
            }
            if let camera = queryParameters.camera {
                parameters.append(URLQueryItem(name: "camera", value: camera))
            }
            parameters.append(URLQueryItem(name: "page", value: "\(queryParameters.page)"))
            
            switch rover {
            case .curiosity:
                url = URLComposer.buildURL(baseUrl: .base, from: .marsCuriosity, queryParameters: parameters, apiKey: queryParameters.authenticated)
            case .opportunity:
                url = URLComposer.buildURL(baseUrl: .base, from: .marsOpportunity, queryParameters:  parameters, apiKey: queryParameters.authenticated)
            case .spirit:
                url = URLComposer.buildURL(baseUrl: .base, from: .marsSpirit, queryParameters: parameters, apiKey: queryParameters.authenticated)
            }
            print(url)
            NASAAPI.shared.requestObject(url: url, method: .get, nil, encoding: URLEncoding.default, header: .none, completion: completion)
        }
        
    }
}

struct MarsRoverPhotos: Codable {
    var photos: [RoverPhotosObject]?
    
    private enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }
}



struct RoverPhotos: Codable {
    var photos: RoverPhotosObject?
    
    private enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }
}

struct RoverPhotosObject: Codable {
    
    var camera: Camera
    var earthDate: String
    var id: Int
    var imageSource: String
    var rover: Rover
    var sol: Int
    
    private enum CodingKeys: String, CodingKey {
        case camera = "camera"
        case earthDate = "earth_date"
        case id = "id"
        case imageSource = "img_src"
        case rover = "rover"
        case sol = "sol"
    }
}

struct Rover: Codable {
    
    var cameras: [Camera]
    var id: Int
    var landingDate: String
    var launchDate: String
    var maxDate: String
    var maxSol: Int
    var name: String
    var status: String
    var totalPhotos: Int
    
    private enum CodingKeys: String, CodingKey {
        case cameras = "cameras"
        case id = "id"
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case maxDate = "max_date"
        case maxSol = "max_sol"
        case name = "name"
        case status = "status"
        case totalPhotos = "total_photos"
    }
}

struct Camera: Codable {
    
    var id: Int?
    var name: String
    var roverId: Int?
    var fullName: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case roverId = "rover_id"
        case fullName = "full_name"
    }
}


