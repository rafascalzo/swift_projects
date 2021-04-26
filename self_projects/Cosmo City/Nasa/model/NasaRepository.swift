//
//  NasaRepository.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/7/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class NasaRepository: NSObject {
    
    func saveMedia(media:Dictionary<String,String>){
        
        NASADAO().saveMedia(mediaDictionary: media)
    }
    
    func retrieveMedia(completion:@escaping(_ mediaList:Array<Media>) -> Void){
        
        var mediaList:Array<Media> = []
        
        
        NASAApiClient().request { () in

            mediaList = NASADAO().retrieveMedia()
            completion(mediaList)

        }
        
//        mediaList = NASADAO().retrieveMedia()
//        completion(mediaList)
      
    }
    
    func deleteMedia(media:Media){
        guard media.date != nil else{return}
        NASADAO().deleteMedia(media)
    }
    

}
