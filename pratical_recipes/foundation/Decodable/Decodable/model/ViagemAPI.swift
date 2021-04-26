import Foundation

class ViagemAPI {
    
    
    func getViagens() -> [[String: Any]]? {
        //se rceber numa variavel um Data opcional, entao
        if let caminho = Bundle.main.url(forResource: "viagens", withExtension: "json"){
            // transformar para um Data não opcional
            let json: Data = try! Data(contentsOf: caminho)
            do{
                
                //recebe em uma variavel um objeto de json serializado
                let viagens =  try JSONSerialization.jsonObject(with: json, options: .allowFragments)
                //converte para um dicionario de String:Any
                let listaDeViagens = viagens as? [[String: Any]]
                return listaDeViagens
            }catch{
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
