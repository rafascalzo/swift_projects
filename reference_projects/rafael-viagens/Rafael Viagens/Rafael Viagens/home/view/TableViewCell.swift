import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var labelTitulo: UILabel!
    @IBOutlet var labelQuantidadeDeDias: UILabel!
    @IBOutlet var labelPreco: UILabel!
    @IBOutlet var imageViagem: UIImageView!
    
    
    func configuraCelula(viagem:Viagem){
        labelTitulo.text = viagem.titulo
        labelQuantidadeDeDias.text = viagem.quantidadeDeDias == 1 ? "1 dia" : "\(viagem.quantidadeDeDias) dias"
        labelPreco.text = "R$ \(viagem.preco)"
        imageViagem.image = UIImage(named: viagem.caminhoDaImagem)
        imageViagem.layer.cornerRadius = 10
        //coloca uma mascara de corte para a imagem ficar arredondada
        imageViagem.layer.masksToBounds = true
    }
}
