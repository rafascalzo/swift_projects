//
//  Safari.swift
//  Full Square
//
//  Created by rafaeldelegate on 8/27/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class Safari : NSObject {
    
    func open(url : String, from controller : UIViewController){
       
            var formatedUrl = url
            
            if !formatedUrl.hasPrefix("http://") {
                formatedUrl = String(format: "http://%@", formatedUrl)
            }
            guard let url = URL(string: formatedUrl) else { return }
        
            let safariViewController = SFSafariViewController(url: url)
        
            controller.present(safariViewController, animated: true, completion: nil)
       
    }
}
