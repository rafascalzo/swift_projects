//
//  PinDAO.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 08/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit
import CoreData

class PinDAO: NSObject {
    
    var fetchManagerResults:NSFetchedResultsController<PinMarker>?

    var context:NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func retrievePins() ->Array<PinMarker> {
        let pinFetch:NSFetchRequest<PinMarker> = PinMarker.fetchRequest()
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
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
        
        guard let name = pin.title else {return}
        
        let pins = retrievePins().filter() {$0.name == name}
        
        if pins.count > 0{
            guard let foundedPin = pins.first else {return}
            newPin = foundedPin
        }else{
            let entity =  NSEntityDescription.entity(forEntityName: "PinMarker", in: context)
            newPin = NSManagedObject(entity: entity!, insertInto: context)
        }
        
        let discipline = pin.category
        let site = pin.site
        let telephone = pin.telephone
        let image = pin.image
        let latitude = pin.coordinate.latitude
        let longitude = pin.coordinate.longitude
        
        newPin?.setValue(name , forKey: "name")
        newPin?.setValue(discipline, forKey: "category")
        newPin?.setValue(site, forKey: "site")
        newPin?.setValue(telephone, forKey: "telephone")
        newPin?.setValue(image, forKey: "image")
        newPin?.setValue(latitude, forKey: "latitude")
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
