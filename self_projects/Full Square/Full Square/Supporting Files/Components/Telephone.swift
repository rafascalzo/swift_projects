//
//  Telephone.swift
//  Full Square
//
//  Created by rafaeldelegate on 9/1/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit

class Telephone: NSObject {
        
        func makeACallTo(_ selectedPin:PinMarker){
            
            
            guard let telephoneNumber = selectedPin.telephone else { return }
            if let url = URL(string: "tel://\(telephoneNumber)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
}
