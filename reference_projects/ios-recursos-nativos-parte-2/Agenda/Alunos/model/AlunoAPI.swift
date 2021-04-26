import UIKit
import Alamofire

class AlunoAPI: NSObject {
    
    // MARK: GET
    func recuperaAlunos(completion:@escaping() -> Void){
        
        Alamofire.request("http://localhost:8080/api/aluno", method: .get).responseJSON(completionHandler: { (response) in
            switch response.result{
            case .success:
                print(response.result.value!)
                
                if let resposta = response.result.value as? Dictionary<String,Any>{
                    guard let listaDeAlunos = resposta["alunos"] as?
                        Array<Dictionary<String,Any>> else {return}
                    for dicionarioDeAluno in listaDeAlunos{
                        AlunoDAO().salvaAluno(dicionarioDeAluno: dicionarioDeAluno)
                    }
                    
                    completion()
                }
                break
            case .failure:
                print(response.error!)
                completion()
                break
            }
            })
    }
    
    // MARK: PUT
    
    func salvaAlunosNoServidor(_ parametros:Array<Dictionary<String,String>>){
        
       guard let url = URL(string: "http://localhost:8080/api/aluno/lista")else {return}
        
        //este primeiro metodo ira dar um erro quando passamos uma lista..
        //iremos utilizar a classe URLrequest para criar a requisicao
        //Alamofire.request(url, method: .put, parameters: [:])
        
        var requisicao = URLRequest(url: url)
        let json = try! JSONSerialization.data(withJSONObject: parametros, options: [])
        
        requisicao.httpMethod = "PUT"
        requisicao.httpBody = json
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(requisicao)
    }
    
    // MARK: DELETE
    func deletaAluno(id:String){
        
        Alamofire.request("http://localhost:8080/api/aluno/\(id)", method: .delete).responseJSON { (resposta) in
            switch resposta.result{
            case .failure:
                (print(resposta.result.error!))
                break;
            default:
                break;
            }
        }
        
    }

}
