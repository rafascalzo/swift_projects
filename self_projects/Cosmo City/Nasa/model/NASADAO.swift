//
//  NASADAO.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/5/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import CoreData

class NASADAO: NSObject {

    var fetchResultManager:NSFetchedResultsController<Media>?
    //contexto do coredata
    var context:NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func retrieveMedia() ->Array<Media> {
        let fetchMedia:NSFetchRequest<Media> = Media.fetchRequest()
        let sortByDate = NSSortDescriptor(key: "date", ascending: true)
        fetchMedia.sortDescriptors = [sortByDate]
        
        fetchResultManager = NSFetchedResultsController(fetchRequest: fetchMedia, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchResultManager?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        guard let mediasList = fetchResultManager?.fetchedObjects else  {return []}
        return mediasList
    }
    
    func saveMedia(mediaDictionary:Dictionary<String,Any>){
        
        var media:NSManagedObject?
        
        guard let date = mediaDictionary["date"] as? String else{return}
  
        let medias = retrieveMedia().filter() {$0.date == date}
       
        print("Today is \(date)")
        
        if medias.count > 0{
            guard let fetchedMedia = medias.first else {return}
            media = fetchedMedia
        }else{
            let entity =  NSEntityDescription.entity(forEntityName: "Media", in: context)
            media = NSManagedObject(entity: entity!, insertInto: context)
        }
     
        media?.setValue(mediaDictionary["copyright"] , forKey: "copyright")
        media?.setValue(mediaDictionary["date"], forKey: "date")
        media?.setValue(mediaDictionary["explanation"], forKey: "explanation")
        media?.setValue(mediaDictionary["media_type"], forKey: "mediaType")
        media?.setValue(mediaDictionary["service_version"] , forKey: "serviceVersion")
        media?.setValue(mediaDictionary["title"], forKey: "title")
        media?.setValue(mediaDictionary["url"], forKey: "url")
        media?.setValue(mediaDictionary["hdurl"], forKey: "hdurl")
        
        updateContext()
    }
    
    func deleteMedia(_ media:Media){
        context.delete(media)
        updateContext()
    }
    
    func updateContext(){
        do {
            try context.save()
            // navigationController?.popViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }

}
