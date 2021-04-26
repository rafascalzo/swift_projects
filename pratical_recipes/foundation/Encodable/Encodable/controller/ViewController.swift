import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritaViagem()
        }
    
    func favoritaViagem(){
        let viagem = Viagem(1, "Cancun - Mexico", 10, "6.500,00", "Quintana Roo")
        
       /*
         //estrutura antiga para montar um JSON, um dicionario...
         
         let parametros:[String: Any] = ["id" : viagem.id, "titulo": viagem.titulo, "quantidadeDeDias" : viagem.quantidadeDeDias, "preco": viagem.preco , "localizacao" : viagem.localizacao]
        
        print(parametros)*/
        
        let viagemCodificada = try? JSONEncoder().encode(viagem)
        
        guard let viagemData = viagemCodificada else {return}
        
        if let json = String(data: viagemData, encoding: .utf8){
              print(json)
        }
        
      
        
    }


}

