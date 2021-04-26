//
//  Thumbnails.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/16/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit

struct CharacterDataWrapper: Decodable {
    
    var code:Int?
    var status:String?
    var copyright:String?
    var attributionText:String?
    var attributionHTML:String?
    var data: CharacterDataContainer?
    var etag:String?
}

extension CharacterDataWrapper {
    
    struct CharacterDataContainer: Decodable {
        var offset:Int?
        var limit:Int?
        var total:Int?
        var count:Int?
        var results:[Character]?
    }
}

extension CharacterDataWrapper.CharacterDataContainer {
    
    struct Character: Decodable {
        
        var id:Int?
        var name:String?
        var description:String?
        //var modified:Date?
        var resourceURI:String?
        var urls:[Url]?
        var thumbnail:Image?
        var comics:ComicList?
        var stories:StoryList?
        var events:EventList?
        var series:SeriesList?
        
    }
}

extension CharacterDataWrapper.CharacterDataContainer.Character {
    
    struct Url : Decodable {
        var type:String?
        var url:String?
    }
    
    struct Image : Decodable {
        var path:String?
        var `extension`:String?
        
    }
    
    struct ComicList : Decodable {
        var available : Int?
        var returned : Int?
        var collectionURI : String?
        var items : [ComicSummary]?
    }
    
    struct StoryList : Decodable {
        var available : Int?
        var returned : Int?
        var collectionURI : String?
        var items : [StorySummary]?
    }
    
    struct EventList :Decodable {
        
        var available:Int?
        var returned:Int?
        var collectionURI:String?
        var items:[EventSummary]?
    }
    
    struct SeriesList : Decodable {
        var available:Int?
        var returned:Int?
        var collectionURI:String?
        var items:[SeriesSummary]?
        
    }
}

extension CharacterDataWrapper.CharacterDataContainer.Character.ComicList{
    
    struct ComicSummary : Decodable {
        var resourceURI:String?
        var name:String?
    }
}

extension CharacterDataWrapper.CharacterDataContainer.Character.StoryList {
    
    struct StorySummary: Decodable {
        var resourceURI:String?
        var name:String?
        var type:String?
    }
}

extension CharacterDataWrapper.CharacterDataContainer.Character.EventList {
    
    struct EventSummary : Decodable {
        var resourceURI:String?
        var name:String?
    }
}

extension CharacterDataWrapper.CharacterDataContainer.Character.SeriesList{
    struct SeriesSummary: Decodable {
        
        var resourceURI:String?
        var name:String?
    }
}

