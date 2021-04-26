//
//  WheaterApi.swift
//  Wheater
//
//  Created by rafaeldelegate on 7/3/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import Alamofire

class WheaterApi: NSObject {
    
//    App Credentials
//    Project: default-application_3815089
//    Key: 1d0e412918msh1074904d7a797eep1d2059jsnf24ab9f9c177
//    (HIDE)
    
    let headers: HTTPHeaders = [
        "X-Mashape-Key": "1d0e412918msh1074904d7a797eep1d2059jsnf24ab9f9c177",
        "Accept": "application/json"]
    
    let url = "https://community-open-weather-map.p.rapidapi.com/weather"
    //let host = "community-open-weather-map.p.rapidapi.com"
    let params = ["London":"uk"]
    
    func getData(completion: @escaping ([String:Any]) -> Void) {
        
        Alamofire.request(url, method: .get, parameters: params, headers: headers).responseJSON { (response) in
            
            
            switch response.result {
            case .success :
                print(response)
                break
            case .failure(_):
                print("aaaaaaa")
                break
            }
            guard let resposta = response.result.value as? [String:Any] else{
                print("N deu mano")
                return
            }
            
            completion(resposta)
        }
        
    }

}
