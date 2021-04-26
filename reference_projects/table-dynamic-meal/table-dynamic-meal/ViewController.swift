
import UIKit

//extensao para UITableViewController é para o caso de utilizar uma lista em uma tela inteira
//caso fosse o caso de adicionar uma table controller e outras coisas (dividir a tela em varios layouts) extender da classe UIViewControlller.

class ViewController: UITableViewController {
    
    let meals = ["eggyplant-brownie", "zucchini muffin", "rafael's sundubu"]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("tela carregada com sucesso")
    }
    
    
    // retorna o numero de elementos que temos no vetor
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    // funcao chamada para cada uma das celulas
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row // retorna posicao
        let meal = meals[row] // pega string da primeira posicao
        
        //estilo default, reusar identificador por padrao é nulo
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel!.text = meal // acessar textlabel, colocar string dentro para ser exibida
        return cell
    }


}

