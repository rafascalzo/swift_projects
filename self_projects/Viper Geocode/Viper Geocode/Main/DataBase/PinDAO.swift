//
//  PinDao.swift
//  Viper Geocode
//
//  Created by rafaeldelegate on 8/10/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import CoreData

class PinDAO: NSObject {
    
    var fetchManagerResults:NSFetchedResultsController<PinMarker>?
    
    var context:NSManagedObjectContext {
        let coreDataManager = CoreDataManager.sharedDatabaseManager
        return coreDataManager.persistentContainer.viewContext
    }
    
    func retrievePins() ->Array<PinMarker> {

        let pinFetch:NSFetchRequest<PinMarker> = PinMarker.fetchRequest()
        let sortByName = NSSortDescriptor(key: "title", ascending: true)
        pinFetch.sortDescriptors = [sortByName]
        
        fetchManagerResults = NSFetchedResultsController(fetchRequest: pinFetch, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchManagerResults?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        guard let pinList = fetchManagerResults?.fetchedObjects else  {return []}
        return pinList
    }
    
    func salvePin(_ pin : Pin){
        
        var newPin:NSManagedObject?
        
        guard let title = pin.title else {return}
        
        let pins = retrievePins().filter() {$0.title == title}
        
        if pins.count > 0{
            guard let foundedPin = pins.first else {return}
            newPin = foundedPin
        }else{
            let entity =  NSEntityDescription.entity(forEntityName: "PinMarker", in: context)
            newPin = NSManagedObject(entity: entity!, insertInto: context)
        }
        let locationName = pin.locationName
        let latitude = pin.coordinate.latitude
        let longitude = pin.coordinate.longitude
        let discipline = pin.discipline
        
        newPin?.setValue(title , forKey: "title")
        newPin?.setValue(locationName, forKey: "location")
        newPin?.setValue(latitude, forKey: "latitude")
        newPin?.setValue(discipline, forKey: "discipline")
        newPin?.setValue(longitude, forKey: "longitude")
        
        updateContext()
    }
    
    func deletePin(_ pin:PinMarker){
        context.delete(pin)
        updateContext()
    }
    
    func updateContext(){
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
