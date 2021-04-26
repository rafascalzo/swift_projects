import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       getViagens()
    }
    
    func getViagens() {
        //recebe um dicionario no formato String:Any
        guard  let json = ViagemAPI().getViagens() else {return}
        //converte o dicionario para data
        guard let jsonData = Viagem.converteListaParaData(json) else {return}
        //decodifica o arquivo data para um arquivo do tipo array de viagens
        guard let listaDeViagem = Viagem.decodificaViagem(jsonData) else {return}
        
        for viagem in listaDeViagem {
            print(viagem.titulo)
        }
        
      /*
         metodo antigo
         
         let listaDeViagem = Viagem().desserializa(json)
        
        for viagem in listaDeViagem {
             print(viagem.titulo)
        }*/
    }


}

