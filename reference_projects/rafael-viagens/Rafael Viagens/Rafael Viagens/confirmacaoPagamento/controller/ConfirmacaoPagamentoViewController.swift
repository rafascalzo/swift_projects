//
//  ConfirmacaoPagamentoViewController.swift
//  Rafael Viagens
//
//  Created by RVSM on 28/05/19.
//  Copyright © 2019 RVSM. All rights reserved.
//

import UIKit

class ConfirmacaoPagamentoViewController: UIViewController {
    var pacoteComprado:PacoteViagem? = nil
    
    @IBOutlet weak var botaoVoltarHome: UIButton!
    @IBAction func botaoVoltarHome(_ sender: UIButton) {
        
        if let navigation = navigationController{
            navigation.popToRootViewController(animated: true)
        }
    }
    @IBOutlet weak var imagePacoteViagem: UIImageView!
    @IBOutlet weak var labelTituloPacoteViagem: UILabel!
    
    @IBOutlet weak var labelHotelPacoteViagem: UILabel!
    @IBOutlet weak var labelDataPacoteViagem: UILabel!
    
    @IBOutlet weak var labelQuantidadePessoas: UILabel!
    @IBOutlet weak var labelDescricaoPacoteViagem: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pacote = pacoteComprado{
            self.imagePacoteViagem.image = UIImage(named: pacote.viagem.caminhoDaImagem)
            self.labelTituloPacoteViagem.text = pacote.nomeDoHotel.uppercased()
            self.labelHotelPacoteViagem.text = pacote.nomeDoHotel
            self.labelDataPacoteViagem.text = pacote.dataViagem
            self.labelDescricaoPacoteViagem.text = pacote.descricao
            
            self.imagePacoteViagem.layer.cornerRadius = 10
            self.imagePacoteViagem.layer.masksToBounds  = true
            
            self.botaoVoltarHome.layer.cornerRadius = 8
        }
    }
}
