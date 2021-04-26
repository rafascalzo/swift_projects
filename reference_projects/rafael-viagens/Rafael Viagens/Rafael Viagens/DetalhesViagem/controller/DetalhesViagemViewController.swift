import UIKit

class DetalhesViagemViewController: UIViewController {
    
    var pacoteSelecionado:PacoteViagem? = nil

    @IBOutlet weak var imagemDoPacote: UIImageView!
    @IBOutlet weak var labelTituloDoPacote: UILabel!
    @IBOutlet weak var labelDescricaoDoPacote: UILabel!
    @IBOutlet weak var labelDataDoPacote: UILabel!
    @IBOutlet weak var labelPrecoDoPacote: UILabel!
    @IBOutlet weak var textFieldData: UITextField!
    @IBOutlet weak var textFieldNumeroDoCartao: UITextField!
    @IBOutlet weak var textFieldNomeDoCartao: UITextField!
    @IBOutlet weak var textFieldSenha: UITextField!
    
    // MARK: - IBActions
    
    @IBAction func buttonFinalizarCompra(_ sender: UIButton) {
        
        if Validador.validaTextFields([textFieldNumeroDoCartao, textFieldNomeDoCartao, textFieldData, textFieldSenha]) {
            Validador.pulse(sender)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
             let controller = storyboard.instantiateViewController(withIdentifier: "confirmacaoPagamento") as! ConfirmacaoPagamentoViewController
             controller.pacoteComprado = pacoteSelecionado
             self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @IBAction func textFieldData(_ sender: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        sender.inputView = datePicker
        datePicker.addTarget(self, action: #selector(exibeData(sender:)), for: .valueChanged)
    }
        
    @IBAction func botaoVoltar(){
        if let navigation = navigationController{
            navigation.popViewController(animated: true)
        }
    }
    
    @IBOutlet weak var scrollPrincipal: UIScrollView!
    
    @objc func aumentarScroll(notification: Notification){
        self.scrollPrincipal.contentSize = CGSize(width: self.scrollPrincipal.frame.width, height: self.scrollPrincipal.frame.height + 320)
        //comando abaixo para colocar o foco na variavel
       // self.scrollPrincipal.contentOffset.y = 200
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //envia notificacao de quando o teclado subir
    NotificationCenter.default.addObserver(self, selector: #selector(aumentarScroll(notification:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        
        if let pacote = pacoteSelecionado{
            self.imagemDoPacote.image = UIImage.init(named: pacote.viagem.caminhoDaImagem)
            self.labelTituloDoPacote.text = pacote.viagem.titulo
            self.labelDescricaoDoPacote.text = pacote.descricao
            self.labelPrecoDoPacote.text = pacote.viagem.preco
            self.labelDataDoPacote.text = pacote.dataViagem
            
        }
    }
    
    // MARK: - Private methods
    @objc func exibeData(sender:UIDatePicker){
         let formatador = DateFormatter()
         formatador.dateFormat = "dd MM yyyy"
         textFieldData.text = formatador.string(from: sender.date)
     }
}
