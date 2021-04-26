import Foundation
import UIKit

class RemoveViewController {
    
    // controller instanciado para recuperar o contexto de onde veio
    let controller: UIViewController
    
    init(controller:UIViewController) {
        self.controller = controller
    }
    // notacao escaping para dizer que o handler durara mais tempo que o padrao, pois ela vem de uma outra funcao que esta em outra classe e tem um tempo padrao de duracao
    
    // funcao que recebe uma funcao por paramentro
    //recebe um UIAlertAction e devolve nada
    func show(_ meal: Meal, handler: @escaping (UIAlertAction) -> Void){
        
        let details = UIAlertController(title: meal.name, message: meal.details(), preferredStyle:UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        details.addAction(cancel)
        
        /*func removeSelected(action: UIAlertAction){
         print("removed the selected one \(meal.name)")
         meals.remove(at: row)
         tableView.reloadData()
         }
         
         let remove = UIAlertAction(title: "Remove", style: UIAlertAction.Style.destructive, handler: removeSelected)
         details.addAction(remove)*/
        
        //definindo e utilizando uma closure
        // utilizando uma closure em nosso handler
        //utilizado para funcoes com poucas responsabilidades
        //ps ACTION in representa que estamos passando uma funcao por parametro
        // compilador forca a nos dizer que a variavel e local da classe (self) pois a mesma pode ter sido removida ou alterada no meio do caminho
        let remove = UIAlertAction(title: "Remove", style: UIAlertAction.Style.destructive, handler: handler)
        details.addAction(remove)
        
        controller.present(details, animated: true, completion: nil)
    }
}
