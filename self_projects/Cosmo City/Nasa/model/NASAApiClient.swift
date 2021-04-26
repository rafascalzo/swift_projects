//
//  NASAApiClient.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 6/30/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import Alamofire

class NASAApiClient: NSObject {
    // https://api.nasa.gov/planetary/apod?api_key=EFFbwILdA568NTtVxenLWWwCqgZNG1D2yNQR8GD2
    let urlPath = "https://api.nasa.gov/planetary/apod?api_key=A3TdFqjRkcsm3tuROuB326gggubyCe9GaNbuATdf"
    
    func request(completion: @escaping () -> Void){
        
        Alamofire.request(urlPath, method: .get).responseJSON { (response) in
            
            switch response.result{
            case .success:
                guard let mediaList = response.result.value as? Dictionary<String,Any> else {return}
              
                NASADAO().saveMedia(mediaDictionary: mediaList)
                
                completion()
                
                break
                
            case .failure:
                
                break
            }
            
        }
    }
    

}
