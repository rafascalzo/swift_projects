import UIKit
import CoreData

class AlunoDAO: NSObject {
    
        var gerenciadorDeResultados:NSFetchedResultsController<Aluno>?
    //contexto do coredata
    var contexto:NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func recuperaAlunos() ->Array<Aluno> {
        let pesquisaAluno:NSFetchRequest<Aluno> = Aluno.fetchRequest()
        let ordenaPorNome = NSSortDescriptor(key: "nome", ascending: true)
        pesquisaAluno.sortDescriptors = [ordenaPorNome]
        
        gerenciadorDeResultados = NSFetchedResultsController(fetchRequest: pesquisaAluno, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try gerenciadorDeResultados?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        guard let listaDeAlunos = gerenciadorDeResultados?.fetchedObjects else  {return []}
        return listaDeAlunos
    }
    
    func salvaAluno(dicionarioDeAluno:Dictionary<String,Any>){
        //desta forma fixa, sempre ira criar um aluno novo a partir do contexto
        //nao é a melhor forma de fazer isso
        //  let aluno = Aluno(context: contexto)
        
        var aluno:NSManagedObject?
        
        guard let id = UUID(uuidString: dicionarioDeAluno["id"] as! String)else{return}
        
        //filter funciona como um for, percorre todo o banco verificando se o id é igual
        let alunos = recuperaAlunos().filter() {$0.id == id}
        
        if alunos.count > 0{
            guard let alunoEncontrado = alunos.first else {return}
            aluno = alunoEncontrado
        }else{
            let entidade =  NSEntityDescription.entity(forEntityName: "Aluno", in: contexto)
            aluno = NSManagedObject(entity: entidade!, insertInto: contexto)
        }
        
        //aluno.id = id
        //aluno.nome = dicionarioDeAluno["nome"] as? String
        //aluno.endereco = dicionarioDeAluno["endereco"] as? String
        //aluno.telefone = dicionarioDeAluno["telefone"] as? String
        //aluno.site = dicionarioDeAluno["site"] as? String
        aluno?.setValue(id, forKey: "id")
        aluno?.setValue(dicionarioDeAluno["nome"] , forKey: "nome")
        aluno?.setValue(dicionarioDeAluno["endereco"], forKey: "endereco")
        aluno?.setValue(dicionarioDeAluno["telefone"], forKey: "telefone")
        aluno?.setValue(dicionarioDeAluno["site"], forKey: "site")
        
        guard  let nota = dicionarioDeAluno["nota"] else {return}
        if(nota is String){
           // aluno.nota = (dicionarioDeAluno["nota"] as! NSString).doubleValue
            aluno?.setValue((dicionarioDeAluno["nota"] as! NSString).doubleValue, forKey: "nota")
            }else{
            let conversaoDeNota = String(describing: nota)
            //aluno.nota = (dicionarioDeAluno["nota"] as! NSString).doubleValue
            aluno?.setValue((conversaoDeNota as NSString).doubleValue, forKey: "nota")
        }
        //aluno.foto = imageAluno.image
       atualizaContexto()
       }
    
    func deletaAluno(_ aluno:Aluno){
        contexto.delete(aluno)
        atualizaContexto()
    }
    
    func atualizaContexto(){
        do {
            try contexto.save()
           // navigationController?.popViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }
}
