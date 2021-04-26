//
//  DiscoveryViewDelegate.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/27/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit

protocol DiscoveryViewDelegate: class {
    
    func backtoHome()
    func handleTapPress(_ sender: Any)
    func showTipsOptionsView()
    func showTips(_ sender: Any)
    func setupNavigation()
    func dismissTipsOptions(recognizer : UITapGestureRecognizer)
    
}
