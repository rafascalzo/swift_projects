import UIKit

class ViewController: UIViewController {
    
    let listaDeViagens : Array<Viagem> = ViagemDAO().retornaTodasAsViagens()
    
    @IBOutlet var viagensTableView: UITableView!
    @IBOutlet var viewHoteis: UIView!
    @IBOutlet var viewPacotes: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.viagensTableView.dataSource = self
        self.viagensTableView.delegate = self
        self.viewHoteis.layer.cornerRadius = 10
        self.viewPacotes.layer.cornerRadius = 10
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeViagens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let viagemAtual = listaDeViagens[indexPath.row]
        
        cell.configuraCelula(viagem: viagemAtual)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //classe UIDevice retorna informacoes como nivel de bateria, ou aparelho que o usuario esta usando, etc, muito bom!
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 175 : 260
    }
    
    
    
}

