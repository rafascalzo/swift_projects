import Foundation
class Viagem:NSObject, Decodable {
    
    //encodar campos para compatibilidade com json
    enum CodingKeys: String, CodingKey {
        case id, titulo, quantidadeDeDias="quantidade_de_dias", preco, localizacao
    }
    
    //
    
    let id:Int
    let titulo:String
    let quantidadeDeDias:Int
    let preco:String
    let localizacao:String
    
    init(_ id:Int, _ titulo:String, _ quantidadeDeDias:Int, _ preco:String, _ localizacao:String) {
        
        self.id = id
        self.titulo = titulo
        self.quantidadeDeDias = quantidadeDeDias
        self.preco = preco
        self.localizacao = localizacao
    }
    
    
    /*
     
     //forma antiga para desserializar um objeto
     
    convenience init() {
        self.init(0, "", 0, "", "")
    }
    
    func desserializa(_ json: [[String:Any]]) -> [Viagem]{
        
        var listaDeViagens: [Viagem] = []
        
        for viagem in json{
            
          guard let id = viagem["id"] as? Int else {
                print("erro ao converter id para int")
                return listaDeViagens
            }
            guard let titulo = viagem["titulo"] as? String else {
                print("erro ao converter titulo para String")
                return listaDeViagens
            }
            guard let quantidadeDeDias = viagem["quantidade_de_dias"] as? Int else {
                print("erro ao converter quantidade de dias para int")
                return listaDeViagens
            }
            
            guard let preco = viagem["preco"] as? String else {
                print("erro ao converter preco para String")
                return listaDeViagens
            }
            guard let localizacao  = viagem["localizacao"] as? String else {
                print("erro ao converter localizacao para String")
                return listaDeViagens
            }
            
            let novaViagem = Viagem(id, titulo, quantidadeDeDias, preco, localizacao)
            listaDeViagens.append(novaViagem)
        }
        
        
        return listaDeViagens
    }*/
    
    //recebe um dicionario de String:Any e devolve um data opcional
    class func converteListaParaData(_ json: [[String:Any]]) -> Data? {
        //colchetes no options: significa nada???, padrao
        return try? JSONSerialization.data(withJSONObject: json, options: [])
    }
    
    //
    class func decodificaViagem(_ jsonData: Data) -> [Viagem]? {
        do {
              return try JSONDecoder().decode([Viagem].self, from: jsonData)
            
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
}
