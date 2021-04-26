//
//  Dao.swift
//  eggplant-brownie
//
//  Created by rafael-estagio on 21/05/19.
//  Copyright © 2019 rafael-estagio. All rights reserved.
//

import Foundation
class Dao {
    
    let mealsArchive: String
    let itemsArchive:String
    
    init() {
        //recupera diretório do primeiro usuario do sistema
        let userDirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let dir = userDirs[0]
        
        
        //cria um arquivo no diretorio dir, onde nossos dados serao salvos
        mealsArchive = "\(dir)/eggyplant-brownie-meals.data"
        itemsArchive = "\(dir)/eggyplant-brownie-items.data"
    }
    
    func save(_ meals: Array<Meal>){
        
        //pega os dados do nosso array e manda para o arquivo que criamos
        NSKeyedArchiver.archiveRootObject(meals, toFile: mealsArchive)
    }
    
    func load() -> Array<Meal> {
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: mealsArchive){
            let meals = loaded as! Array<Meal>
            return meals
        }
        return []
        //return Array<Meal>()
    }
    
    func save(_ items:Array<Item>){
        NSKeyedArchiver.archiveRootObject(items, toFile: itemsArchive)
    }
    
    func load() -> Array<Item>{
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: itemsArchive){
            let items = loaded as! Array<Item>
            return items
        }
        return []
    }
    

    
}
