import UIKit
class Repositorio: NSObject {
    
    func salvaAluno(aluno:Dictionary<String,String>){
        AlunoAPI().salvaAlunosNoServidor([aluno])
        AlunoDAO().salvaAluno(dicionarioDeAluno: aluno)
    }
    
    func recuperaAlunos(completion:@escaping(_ listaDeAlunos:Array<Aluno>) -> Void){
        var alunos = AlunoDAO().recuperaAlunos()
        if alunos.count == 0 {
            AlunoAPI().recuperaAlunos {
            alunos = AlunoDAO().recuperaAlunos()
            completion(alunos)
            }
        }else{
            completion(alunos)
        }
    }
    
    func DeletaAluno(aluno:Aluno){
        guard let id = aluno.id else{return}
        
        AlunoAPI().deletaAluno(id: String(describing: id).lowercased())
        AlunoDAO().deletaAluno(aluno)
    }
    
    func sincronizaAlunos(){
        let alunos = AlunoDAO().recuperaAlunos()
        var listaDeParametros:Array<Dictionary<String, String>> = []
        
        for aluno in alunos{
            guard let id = aluno.id else{return}
            let parametros:Dictionary<String, String> = [
                
                "id": String(describing: id).lowercased(),
                //como a variavel aluno é opcional, podemos utilizar outro neto de extracao
                //utiliza-se os dois pontos de interrogacao se nao conseguir extrair retorna string vazia
                "nome": aluno.nome ?? "",
                "endereco": aluno.endereco ?? "",
                "telefone": aluno.telefone ?? "",
                "site" : aluno.site ?? "",
                "nota" : "\(aluno.nota)"
                ]
            
            listaDeParametros.append(parametros)
            }
        AlunoAPI().salvaAlunosNoServidor(listaDeParametros)
    }
}
