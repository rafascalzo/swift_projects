import Foundation
//serializacao
class Viagem: NSObject, Encodable{
    //encodar campos para compatibilidade
    enum CodingKeys : String, CodingKey {
        case id, titulo, quantidadeDeDias = "quandidade_de_dias", preco, localizacao
    }
    //MARK: - Atributos
    
    let id: Int
    let titulo:String
    let quantidadeDeDias:Int
    let preco:String
    let localizacao:String
    
    init(_ id: Int, _ titulo:String, _ quantidadeDeDias:Int, _ preco:String, _ localizacao:String ) {
        self.id = id
        self.titulo = titulo
        self.quantidadeDeDias = quantidadeDeDias
        self.preco = preco
        self.localizacao = localizacao
    }
    
}
