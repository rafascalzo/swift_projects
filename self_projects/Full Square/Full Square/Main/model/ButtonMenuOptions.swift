//
//  ButtonOptions.swift
//  Full Square
//
//  Created by rafaeldelegate on 8/31/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//


enum MenuActionSheetButton{
    case delete
    case edit
}
import UIKit

class ButtonMenuOptions: NSObject {

    func configureButtonOptions(completion:@escaping(_ opcao:MenuActionSheetButton) -> Void) -> UIAlertController {
        let menu = UIAlertController(title: "Atention", message: "chose one option", preferredStyle: .actionSheet)
        let sms = UIAlertAction(title: "Delete button", style: .default) { (acao) in
            completion(.delete)
        }
        menu.addAction(sms)

        let ligacao = UIAlertAction(title: "Edit Button", style: .default) { (acao) in
            completion(.edit)
        }
        menu.addAction(ligacao)

        let cancelar = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        menu.addAction(cancelar)

        return menu
    }

}
