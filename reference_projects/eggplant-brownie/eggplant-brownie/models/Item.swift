import Foundation


// esta fabrica separa o processo de code e decode da nossa classe

//desvantagens, tera que passar o construtor que talvez sera o construtor da nossa classe item (codigo redundante), ou nao

//desvantagens: classe fica fortemente acoplada com a classe Item, portanto deveria estar na nossa classe Item..

//vantagens, pode ser usado esse metodo caso precise serializar para diferentes clientes de diferentes maneiras e de uma maneira simples, ao contrario de implementar em nossa classe que s[o temos uma unica maneira de serializar
//
class ItemFactory {
    
    func decode(aCoder: NSCoder) -> Item {
        return Item(name: "Pipoca", calories: 754)
    }
    func encode(item:Item, aCoder: NSCoder){
        
    }
}

class Item: NSObject, NSCoding {
    
    let name:String
    let calories:Double
    
    init(name:String, calories:Double) {
        self.name=name
        self.calories=calories
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(calories, forKey: "calories")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        calories = aDecoder.decodeDouble(forKey: "calories")
    }
}

/*
extension Item: Equatable {
    func ==(firstItem:Item,secondItem:Item) -> Bool{
        return firstItem.name == secondItem.name && firstItem.calories == secondItem.calories
    }

}*/
//ps: herdar de NSObject imclica em herdar o metodo equatable portanto seria redundante mante-lo
