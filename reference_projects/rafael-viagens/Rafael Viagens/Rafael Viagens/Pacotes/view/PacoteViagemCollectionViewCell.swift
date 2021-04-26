import UIKit

class PacoteViagemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imagemViagem: UIImageView!
    @IBOutlet var labelTitulo: UILabel!
    @IBOutlet var labelQuantidadeDeDias: UILabel!
    @IBOutlet var labelPreco: UILabel!
    
    func configuraCelula(pacoteViagem: PacoteViagem){
        labelTitulo.text = pacoteViagem.viagem.titulo
        labelQuantidadeDeDias.text = "\(pacoteViagem.viagem.quantidadeDeDias) dias"
        labelPreco.text = "R$ \(pacoteViagem.viagem.preco)"
        imagemViagem.image = UIImage(named: pacoteViagem.viagem.caminhoDaImagem)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(red: 85.0/255, green: 85.0/255, blue: 85.0/255, alpha: 85.0/255).cgColor
        layer.cornerRadius = 8
    }
    }
