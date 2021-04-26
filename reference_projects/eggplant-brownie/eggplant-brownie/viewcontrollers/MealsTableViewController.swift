import UIKit

// informa que a classe usara o protocolo ViewControllerDelegate
class MealsTableViewController : UITableViewController, AddAMealDelegate {
    
    var meals = Array<Meal>()
    
    func add(_ meal:Meal){ // _ serve para dizer ao compilador que nao deve-se explicitar o nome do primeiro parametro quando for chama-lo
        // " usar quando nome da funcao é obvio..."
        print("Adding \(meal.name)")
        meals.append(meal)
        Dao().save(meals)
//variavel tableView representa a nossa tableView
        //invoca o metodo para retornar quantos elementos tem na lista func tableView... etc
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
       self.meals = Dao().load()
        	
    }
    
   
    
    // quando o viewcontroller atual se prepara para trocar de tela é chamado este metodo
    //metodo usado para executar funcoes em outra tela como se estivesse na tela desejada
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        //assim que criar um segue deve-se criar um identificador para poder reconhece-lo em outras telas
        if(segue.identifier == "addMeal"){
            
            //ps: varios if-else equivalem a um switch, que normalmente sao extensos e com muitas funcoes dificultando a sua interpretacao. in
        
        //avisar para o controller que esta indo, que a variavel mealsTable dele é da classe que o esta chamando
        
        //quando fizer a conversao > as < deve-se forcar a conversao com (compilador nao sabe que a tela seguinte é do tipo viewcontroller). cast para ViewController
        
        // "tomai uma referencia para mim"
        //pega o destino e configura uma variavel para mim mesmo
            //linha abaixo evita o uso de variaveis globais
        let view = segue.destination as! ViewController
        view.delegate = self
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let meal = meals[row]
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier:nil)
        cell.textLabel!.text = meal.name
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(showDetails))
        cell.addGestureRecognizer(longPressRecognizer)
        
        return cell
    }
    
    
    @objc func showDetails(recognizer: UILongPressGestureRecognizer){
        
        if(recognizer.state == UIGestureRecognizer.State.began){
            
            let cell = recognizer.view as! UITableViewCell
            
            if let indexPath = tableView.indexPath(for: cell){
                let row = indexPath.row
                let meal = meals[row]
                
                RemoveViewController(controller: self).show(meal, handler: {ACTION in self.meals.remove(at: row)
                    self.tableView.reloadData()})
                
            }
           
        }
        
    }
    
   
}

