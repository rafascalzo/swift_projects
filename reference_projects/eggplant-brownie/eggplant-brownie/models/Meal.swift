import Foundation

class Meal : NSObject, NSCoding {
    
    let name:String
    let hapiness:Int
    let items:Array<Item>
    
    //contrutor
    //obs na Interface Builder nao existe construtor, forcando variaveis nao inicializadas
    // tomar cuidado com parametros opcionais, evitar setar valores default
    // usa-se normalmente em variaveis simples
    init(name:String, hapiness:Int, items:Array<Item> = []) {
        self.name=name
        self.hapiness=hapiness
        self.items=items
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(hapiness, forKey: "hapiness")
        aCoder.encode(items, forKey: "items")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.hapiness = aDecoder.decodeInteger(forKey: "hapiness")
        self.items = aDecoder.decodeObject(forKey: "items") as! Array<Item>
    }
    
    
    
    /*
     
     //segundo construtor feito para que o usuario tivesse a opcao de nao inicializar algum campo neste momento (deixar o usuario acostumar com o sistema e dar opcoes mais simples e mais complexas, a medida que o usuario acostuma com o sistema ele tem a opcao de inicializar mais variaveis)
     
     //este segundo construtor pode ser trocado pelo inicializador acima que tem a opcao de inicializar o array com itens passados por parametro e tambem caso nao seja passado nada o construtor inicializa um valor padrao self.items= []
    init(name:String, hapiness:Int){
        self.name=name
        self.hapiness=hapiness
        self.items = []
    }
 */
    
    //exemplo de metodo com retorno
    func allCalories() ->Double {
        // explicitando que a variavel é double atraves do valor
        var total = 0.0
        for item in items{
            total+=item.calories
        }
        return total
    }
    
    func details() ->String {
        var message = "Hapiness: \(hapiness)"
        
        for item in items{
            message += "\n \(item.name) - calories: \(item.calories)"
        }
        return message
    }
}
