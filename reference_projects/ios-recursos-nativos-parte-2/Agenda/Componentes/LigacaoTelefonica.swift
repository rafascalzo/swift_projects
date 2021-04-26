//
//  LigacaoTelefonica.swift
//  Agenda
//
//  Created by rafael-estagio on 31/05/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class LigacaoTelefonica: NSObject {
    
    func fazLigacao(_ alunoSelecionado:Aluno){
        
        guard let numeroDoAluno = alunoSelecionado.telefone else { return }
        if let url = URL(string: "tel://\(numeroDoAluno)"), UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
    }

}
