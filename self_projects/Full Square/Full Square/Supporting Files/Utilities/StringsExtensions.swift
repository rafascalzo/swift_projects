//
//  StringsExtensions.swift
//  Full Square
//
//  Created by rafaeldelegate on 7/31/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    static let customCellIdentifier = "mainViewCellIdentifier"
    
    func condenseWhiteSpace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
