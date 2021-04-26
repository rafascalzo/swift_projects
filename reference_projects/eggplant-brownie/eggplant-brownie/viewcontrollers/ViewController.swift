import UIKit

//classe ViewControler > herda de UIViewControler (UI = user interfafce)

//para criar um tableview separado, implementar protocolo UITableViewDataSource

class ViewController: UIViewController, AddAnItemDelegate{
    
    //variavel criada referencia da classe Mealstable... para acessar o metodo add (delegate)
    //variavel tem que ser opcional pois so e feita na inicializacao
    //quem inicializa o nosso controller é a interface builder, o interface builder é feito de uma maneira que nao podemos trabalhar com o inicializador, portanto a variavel deve-se ser opcional
    //delegate = protocoloco para receber assinatura de metodos comuns entre classes
    var delegate : AddAMealDelegate?
    
    //variavel para receber os itens marcados com checkmark
    var selected = Array<Item>()
    
    var items = [
    Item(name: "Eggplant", calories: 10),
    Item(name: "Brownie", calories: 10),
    Item(name: "Zucchini", calories: 10),
    Item(name: "Muffin", calories: 10),
    Item(name: "Coconut oil", calories: 500),
    Item(name: "Chocolate frosting", calories: 1000),
    Item(name: "Chocolate chip", calories: 1000)
    ]
    
    @IBOutlet var tableView : UITableView?
    
    func add(_ item: Item) {
        items.append(item)
        
        Dao().save(items)
        
        if let table = tableView {
            table.reloadData()
        }else{
            Alert(controller: self).show("Unable to update the itens table")
        }
        
    }
    

    
    //funcao que carrega  a view
   override func viewDidLoad() {
    
    // usar #selector em vez de Selector, passar classe.metodo e fazer notacao @objc na frente do metodo que deseja chamar. swift4
    let newItemButton = UIBarButtonItem(title: "New Item", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.showNewItem))
        navigationItem.rightBarButtonItem = newItemButton
        // o tipo de retorno esta explicito, para que possamos saber qual load queremos
        // se nao estivesse explicito, por exemplo numa variavel nao explicita como um Array<Items>
    //neste caso deveremos explicitar a variavel
        items =  Dao().load()
}
    
    //metodo a ser chamado caso o usuario tenha clicado no botao que criamos
    @objc func showNewItem () {
       // NewItemViewController tem a opcao de passar o arquivo xib para qual sera direcionado
        let newItem = NewItemViewController(delegate:self)
        if let navigation = navigationController{
        navigation.pushViewController(newItem, animated: true)
        } else{
            Alert(controller: self).show()
        }
    }
    
    

    @IBOutlet var nameField : UITextField?
    @IBOutlet var hapinessField : UITextField?

 
    @IBAction func add (){
        
        if let meal:Meal = getMealFromForm(){
            
            if let meals = delegate {
                
                meals.add(meal)
                
                if let navigation = navigationController{
                    navigation.popViewController(animated: true)
                    return
                }else{
                    Alert(controller: self).show(message: "Unable to go back, but the meal was added.")
                }
                //early return
                return
            }
        }
        Alert(controller: self).show()
      }
    
    func convertToInt(_ text:String?) -> Int? {
        if let number = text {
            return Int(number)
        }
        return nil
    }
    
    func getMealFromForm() -> Meal? {
        
         if let name = nameField?.text {
            if let hapiness = convertToInt(hapinessField?.text){
                let meal = Meal(name: name, hapiness: hapiness, items: selected)
                print ("eaten \(meal.name) with hapiness \(meal.hapiness)! with \(meal.items)")
                return meal
            }
           
        }
        
        return nil
    }
    
}

extension ViewController : UITableViewDataSource , UITableViewDelegate{
    //retorna tamanho da tabela
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //adiciona elementos a serem visualizados na tabela
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let item = items[row]
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel!.text = item.name
        
        
        
        return cell
    }
    //marcar em lista com checkmark
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath){
            
            if (cell.accessoryType == UITableViewCell.AccessoryType.none){
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
                let item = items[indexPath.row]
                selected.append(item)
                
            } else{
                cell.accessoryType = UITableViewCell.AccessoryType.none
                let item = items[indexPath.row]
                //metodo lastIndex retorna a ultima posicao que contem o objeto informado (item)
                if let position = selected.lastIndex(of: item){
                    
                    selected.remove(at: position)
                } else{
                    Alert(controller: self).show()
                }
                
            }
            
        } else{
            Alert(controller: self).show()
        }
        
    }
  
}

