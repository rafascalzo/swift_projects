//
//  Fonts.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/15/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    // MARK: - TITLE FONTS
    static let titleFontSmall = UIFont(name: "Adventure", size: UIDevice.current.userInterfaceIdiom == .phone ? 12 : 24)
    
    static let titleFontMedium = UIFont(name: "Adventure", size: UIDevice.current.userInterfaceIdiom == .phone ? 18 : 36)
    
    static let titleFontLarge = UIFont(name: "Adventure", size: UIDevice.current.userInterfaceIdiom == .phone ? 24 : 48)
    
    // MARK: - TEXT FONTS
    static let textFontLarge = UIFont(name: "SFWonderComic", size: UIDevice.current.userInterfaceIdiom == .phone ? 18 : 36)
    
    static let textFontMedium = UIFont(name: "SFWonderComic", size: UIDevice.current.userInterfaceIdiom == .phone ? 12 : 24)
    
    static let textFontSmall = UIFont(name: "SFWonderComic", size: UIDevice.current.userInterfaceIdiom == .phone ? 8 : 16)
    
    
    static let scoreFont = UIFont(name: "SFWonderComicInline", size: UIDevice.current.userInterfaceIdiom == .phone ? 25 : 50)
    
    static let titleImageFont = UIFont(name: "Adventure", size: UIDevice.current.userInterfaceIdiom == .phone ? 30 : 60)
    
    static let searchBarFont = UIFont(name: "Adventure", size: UIDevice.current.userInterfaceIdiom == .phone ? 15 : 30)
    
}
