//
//  CepAPI.swift
//  Cep
//
//  Created by rafaeldelegate on 6/25/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

protocol ZipCodeDelegate {
    
    func getZipCode() -> String
}

import UIKit
import Alamofire

class ZipCodeAPI: NSObject {

    // MARK: GET
    func retrieveZipCode(_ urlPath:String, completion: @escaping(_ zipCodeInfo:Dictionary<String,String>) -> Void){

        Alamofire.request(urlPath, method: .get).responseJSON(completionHandler: { (response) in
            switch response.result{
            case .success:
                let zipCodeInfo = response.result.value as? Dictionary<String,String>
                
                completion(zipCodeInfo!)
                
                //save to data for store a list of a previous query
        
                 break
            case .failure:
                print(response.error!)
               break
            }
        })
    }
    
    
    

}

