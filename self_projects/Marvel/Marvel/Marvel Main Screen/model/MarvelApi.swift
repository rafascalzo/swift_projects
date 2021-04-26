//
//  MarvelApi.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/9/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class MarvelApi: NSObject {
    
    struct Marvel {
        static let publicKey = "76258c743807c1393fc95e16642f6038"
        static let privateKey = "d3c3ea2bd7953bda46636d495b9492766cfef35b"
    }
    
    var success = true
    
    func getCharacteres(offset:Int,limit:Int, _ orderBy:String? = nil,completion: @escaping (_ success:Bool, _ characterDataWrapper:CharacterDataWrapper?) -> Void){
        
        let path = "/characters"
        guard let url = URL(string: "https://gateway.marvel.com/v1/public\(path)")else{return}
        // guard let url = URL(string: "https://gatesdasway.marvel.com/v1/public\(path)")else{return}
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = (ts + Marvel.privateKey + Marvel.publicKey).md5
        let headers = ["Content-Type": "application/json"]
        var params:[String:Any]
        
        if let orderBy = orderBy {
            params = ["orderBy":"\(orderBy)", "offset": "\(offset)", "limit":"\(limit)", "apikey": "\(Marvel.publicKey)",  "ts": "\(ts)",   "hash": "\(hash)" ]
        }else {
            params = ["offset": "\(offset)", "limit":"\(limit)", "apikey": "\(Marvel.publicKey)",  "ts": "\(ts)",   "hash": "\(hash)" ]
        }
        let method:HTTPMethod = .get
        
        Alamofire.request(url, method: method, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success :
                guard let data = response.data else {print("N DEU");return}
                
                do {
                    let chars = try JSONDecoder().decode(CharacterDataWrapper.self, from: data)
                    completion(self.success, chars)
                    
                } catch {
                    print(error)
                }
                break
            case .failure :
                completion(!self.success, nil)
                print("Error: \(String(describing: response.error))")
                
            }
        }
    }
    
    func retrieveCharacteresByName(_ name : String,limit:Int, _ orderBy:String? = nil,completion: @escaping (_ success:Bool, _ characterDataWrapper:CharacterDataWrapper?) -> Void){
        
        let path = "/characters"
        guard let url = URL(string: "https://gateway.marvel.com/v1/public\(path)")else{return}
        // guard let url = URL(string: "https://gatesdasway.marvel.com/v1/public\(path)")else{return}
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = (ts + Marvel.privateKey + Marvel.publicKey).md5
        let headers = ["Content-Type": "application/json"]
        var params:[String:Any]
        
        if let orderBy = orderBy {
            params = ["name":"\(name)", "orderBy":"\(orderBy)", "limit":"\(limit)", "apikey": "\(Marvel.publicKey)",  "ts": "\(ts)",   "hash": "\(hash)" ]
        }else {
            params = [ "name":"\(name)","limit":"\(limit)", "apikey": "\(Marvel.publicKey)",  "ts": "\(ts)",   "hash": "\(hash)" ]
        }
        let method:HTTPMethod = .get
        
        Alamofire.request(url, method: method, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success :
                guard let data = response.data else {print("N DEU");return}
                
                do {
                    let chars = try JSONDecoder().decode(CharacterDataWrapper.self, from: data)
                    completion(self.success, chars)
                    
                } catch {
                    print(error)
                }
                break
            case .failure :
                completion(!self.success, nil)
                print("Error: \(String(describing: response.error))")
                
            }
        }
    }
}




