import UIKit


//classe UIView
class NewItemViewController: UIViewController {

    var delegate:AddAnItemDelegate?
    //obrigatorio o uso do inicializador e tamb[em chamar o metodo da classe pai passando o nibname e o bundle padrao
    //delegate deve ser inicializado tambem
    // tambem deve ser chamado outro inicializador do NSCoder
    //este é um problema da heranca... pode gerar codigos mais complexos sujeito a erros
    //deve-se conhecer bem a classe pai, neste caso ha uma notacao na classe informando via comentario que este metodo deve ser chamado quando criarmos um botao programaticamente
     init(delegate: AddAnItemDelegate) {
        super.init(nibName: "NewItemViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //ligar com a view de cadastro de itens
    @IBOutlet var nameField : UITextField?
    @IBOutlet var caloriesField : UITextField?
    
    @IBAction func addNewItem(){
        
        let name = nameField!.text
        let calories = Double(caloriesField!.text!)
        
        if (name == nil || calories == nil || delegate == nil){
            return
        }
        
        let item = Item(name: name!, calories: calories!)
        print("adding new item...")
        //pedir para o protocolo delegate adicionar o nosso item
        delegate!.add(item)
        
        //declarar navigation para fazer o pop (voltar a view)
        if let navigation = navigationController{
            navigation.popViewController(animated: true)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
