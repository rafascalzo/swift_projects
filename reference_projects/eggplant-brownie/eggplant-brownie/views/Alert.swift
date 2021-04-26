import Foundation
import UIKit

class Alert {
    
    let controller:UIViewController
    
    init(controller:UIViewController){
        self.controller = controller
    }
    
    // detalhe para receber parametros: quando usamos o _ para omitir o que o metodo esta esperando como parametro
    // caso quisermos passar somente a mensagem devemos deixar que o desenvolvedor escreva o tipo do parametro que está passando
    // caso contrário o swift nao sabera interpretar para qual parametro deve ser passado
    func show(_ tittle: String = "Sorry", message: String = "Unexpected error"){
        
        let alert = UIAlertController(title: "Sorry", message: message, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "Understood", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(ok)
        
        //funcao present existe em uma classe do tipo View controller
        //no caso queremos colocar o alerta na tela que esta chamando o metodo dessa classe, portanto devemos passar o nosso controler na hora de instanciar a classe 
        controller.present(alert, animated: true, completion: nil)
    }
    
}
