//
//  Fonts.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 6/30/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    static let fontForTexts = UIFont(name: "Ubuntu-Regular", size: UIDevice.current.userInterfaceIdiom == .phone ? 16 : 32)
    
    static let fontForSublimedTexts = UIFont(name: "Ubuntu-Italic", size: UIDevice.current.userInterfaceIdiom == .phone ? 15 : 30)
    
    static let fontForTitles = UIFont(name: "Ubuntu-Medium", size: UIDevice.current.userInterfaceIdiom == .phone ? 20 : 40)
    
    static let fontForMediaDate = UIFont(name: "Ubuntu-Italic", size: UIDevice.current.userInterfaceIdiom == .phone ? 7 : 14)
    
    static let fontForExplanation = UIFont(name: "Ubuntu-Italic", size: UIDevice.current.userInterfaceIdiom == .phone ? 17 : 34)
    
    static let fontForCellTitle = UIFont(name: "Ubuntu-Medium", size: UIDevice.current.userInterfaceIdiom == .phone ? 16 : 32)
}
