//
//  PinMenuOptions.swift
//  Full Square
//
//  Created by rafaeldelegate on 9/1/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit

enum MenuActionSheetPin {
    case call
    case site
}

class PinMenuOptions: NSObject {

    func showOptions(completion:@escaping(_ opcao:MenuActionSheetPin) -> Void) -> UIAlertController {
        let menu = UIAlertController(title: "Menu options", message: "Choose one option", preferredStyle: .actionSheet)
        
        let sms = UIAlertAction(title: "Make a call", style: .default) { (acao) in
            completion(.call)
        }
        menu.addAction(sms)

        let ligacao = UIAlertAction(title: "Enter site", style: .default) { (acao) in
            completion(.site)
        }
        menu.addAction(ligacao)

        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        menu.addAction(cancel)

        return menu
    }
}
