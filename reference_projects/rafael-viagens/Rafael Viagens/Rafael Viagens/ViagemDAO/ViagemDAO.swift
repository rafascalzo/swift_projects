import UIKit

class ViagemDAO: NSObject {
    
    func retornaTodasAsViagens() -> Array<Viagem> {
        
        let ceara = Viagem("Ceará", 3, "1.800,59", "img1.png")
        
        let rioDeJaneiro = Viagem("Rio de Janeiro", 6, "1.200,00", "img2.jpg")
        
        let interiorSaoPaulo = Viagem("Atibaia - Sao Paulo", 1, "890,00", "img3.jpg")
        
        let paraiba = Viagem("Paraíba", 3, "1.385,00", "img4.jpg")
        
        let fortaleza = Viagem("Fortaleza", 4, "3.120,00", "img5.jpg")
        
        let listaViagem:Array<Viagem> = [rioDeJaneiro, ceara, interiorSaoPaulo, paraiba, fortaleza]
        
        return listaViagem
    }
}
