//
//  Thumbnails.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/16/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit

class CharacterDataWrapper, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case httpStatus = "code", callStatus = "status", copyright
    }
    
    var httpStatus:Int?
    var callStatus:String?
    var copyright:String?
    //attributionText (string, optional): The attribution notice for this result. Please display either this notice or the contents of the attributionHTML field on all screens which contain data from the Marvel Comics API.,
    var attributionText:String?
    //attributionHTML (string, optional): An HTML representation of the attribution notice for this result. Please display either this notice or the contents of the attributionText field on all screens which contain data from the Marvel Comics API.,
    var attributionHTML:String?
    data (CharacterDataContainer, optional): The results returned by the call.,
    etag (string, optional): A digest value of the content returned by the call.
    
}
