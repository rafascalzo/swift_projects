import UIKit

class PacotesViagensViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UICollectionViewDelegate {
    
    @IBOutlet var pesquisarViagensSearchBar: UISearchBar!
    
    @IBOutlet weak var labelContadorDePacotes: UILabel!
    
    var listaComTodasViagens : Array<PacoteViagem> = PacoteViagemDAO().retornaTodasAsViagens()
    var listaViagens:Array<PacoteViagem> = []
    var selectedPackage: PacoteViagem?
    
    @IBOutlet var colecaoDePacotesDeViagens: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        listaViagens = listaComTodasViagens
        self.labelContadorDePacotes.text = atualizaContadorLabel()
        
        colecaoDePacotesDeViagens.dataSource = self
        colecaoDePacotesDeViagens.delegate = self
        pesquisarViagensSearchBar.delegate = self

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return listaViagens.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let celulaPacote = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaPacote", for: indexPath) as! PacoteViagemCollectionViewCell
          let pacoteAtual = listaViagens[indexPath.item]
          celulaPacote.configuraCelula(pacoteViagem: pacoteAtual)
          
          return celulaPacote
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // let larguraDaCelula = collectionView.bounds.width/2
        //return CGSize(width: larguraDaCelula-20, height: 160)
        
        return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: collectionView.bounds.width/2-20, height: 160) : CGSize(width: collectionView.bounds.width/3-20, height: 250)
    }
    
    var selectedFrame: CGRect?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // ps bundle  é nill pois nao alteramos a localizacao inicial do storyboard, continua na mesma estrutura
        let pacote = listaViagens[indexPath.item]
        selectedPackage = pacote
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detalhesDasViagens") as! DetalhesViagemViewController
        //apresenta o controller na tela
        controller.pacoteSelecionado = pacote
        let selectedAttribute = collectionView.layoutAttributesForItem(at: indexPath)
        selectedFrame = selectedAttribute?.frame
        //self.present(controller,animated: true,completion: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        //let filtroListaViagem = NSPredicate(format: "titulo contains %@", searchText)
        //let listaFiltrada:Array<Viagem> = (listaDeViagens as! NSArray).filtered(using: filtroListaViagem)as! Array<Viagem>
        //listaDeViagens = listaFiltrada
        //colecaoDePacotesDeViagens.reloadData()
        
       listaViagens = listaComTodasViagens
        if searchText != "" {
            listaViagens = listaViagens.filter { $0.viagem.titulo.contains(searchText) }
        } else {
            searchBar.searchTextField.resignFirstResponder()
        }
        self.labelContadorDePacotes.text = atualizaContadorLabel()
        colecaoDePacotesDeViagens.reloadData()
    }
    
    func atualizaContadorLabel() -> String {
        return listaViagens.count == 1 ? "1 Pacote encontrado" : "\(listaViagens.count) Pacotes encontrados"
    }
}

extension PacotesViagensViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let imagePath = selectedPackage?.viagem.caminhoDaImagem else { return nil }
        guard let image = UIImage(named: imagePath) else { return nil }
        guard let frame = selectedFrame else { return nil}
        switch operation {
        case .push:
            return CustomTransitionAnimation(TimeInterval(UINavigationController.hideShowBarDuration), image, frame, true)
        default:
            return CustomTransitionAnimation(TimeInterval(UINavigationController.hideShowBarDuration), image, frame, false)
        }
    }
}
