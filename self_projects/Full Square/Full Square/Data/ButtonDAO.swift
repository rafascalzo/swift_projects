//
//  ButtonDAO.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 12/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//
struct ButtonModel {
    
    var id : UUID
    var title : String
    var imageName : String
}
import UIKit
import CoreData

class ButtonDAO: NSObject {
    
    var fetchManagerResults:NSFetchedResultsController<Button>?
    
    var context:NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func retrieveButtons() ->Array<Button> {
        let buttonFetch:NSFetchRequest<Button> = Button.fetchRequest()
        let sortByName = NSSortDescriptor(key: "id", ascending: true)
        buttonFetch.sortDescriptors = [sortByName]
        
        fetchManagerResults = NSFetchedResultsController(fetchRequest: buttonFetch, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchManagerResults?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        guard let pinButton = fetchManagerResults?.fetchedObjects else  {return []}
        return pinButton
    }
    
    func saveButton(_ button : ButtonModel){
        
        var newButton:NSManagedObject?
       
         let id : String = String(describing: button.id)
        
        let buttons = retrieveButtons().filter() {$0.id == id} 
        
        if buttons.count > 0{
            guard let foundedButton = buttons.first else {return}
            newButton = foundedButton
        }else{
            let entity =  NSEntityDescription.entity(forEntityName: "Button", in: context)
            newButton = NSManagedObject(entity: entity!, insertInto: context)
        }
    
        let title = button.title
        let imageName = button.imageName
        newButton?.setValue(id , forKey: "id")
        newButton?.setValue(title, forKey: "title")
        newButton?.setValue(imageName, forKey: "imageName")
        
        updateContext()
    }
    
    func deleteButton(_ button:Button){
        context.delete(button)
        updateContext()
    }
    
    func updateContext(){
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getInitialData() -> [String] {
       return ["hostpital-building","home","ambulance","gamepad-console","shopping-cart"]
    }
    
    func getAllIcons() -> [String] {
        return ["film","ticket","beaker","medical-kit","credit-card","anchor","umbrella","beer","music","cocktail","volume-up","android","apple","barcode","bell","bitcoin-logo","leaves","briefcase","bug","building-front","fire-extinguisher","bull-horn","bullseye","camera-retro","plane","flag","coffee-cup","truck","ball","doctor","eye-open","stethoscope","heart","linux-logo","fire-symbol","hotel","html-5-logo","paper-bill","instagram","telephone","legal-hammer","female-silhouette","fighter-jet","flag2","fork-and-knife","lemon","light-bulb","lightning-bolt","link","sun","wheelchair","rocket","mobile","tint-drop","trophy","open-laptop","wrench","plant","puzzle","suitcase","turkish","dashboard","desktop-monitor","book","cinema","donation","football","law","money","policeman","motor","theatre","wine","bicycle","tooth","dj","college"]
    }
}
