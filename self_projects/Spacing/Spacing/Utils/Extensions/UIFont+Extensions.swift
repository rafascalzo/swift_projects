//
//  UIFont+Extensions.swift
//  Spacing
//
//  Created by rvsm on 06/06/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

extension UIFont {
    
    //static let avenirBoldSmall = UIFont(name: "Avenir-Heavy", size: 10)!
    static let avenirBoldMedium = UIFont(name: "Avenir-Heavy", size: 14)!
    static let avenirBoldLarge = UIFont(name: "Avenir-Heavy", size: 18)!
    
    static let avenirMediumSmall = UIFont(name: "Avenir-Medium", size: 10)!
    static let avenirMediumMedium = UIFont(name: "Avenir-Medium", size: 14)!
    static let avenirMediumLarge = UIFont(name: "Avenir-Medium", size: 18)!
    
    static let avenirLightSmall = UIFont(name: "Avenir-Light", size: 10)!
    static let avenirLightMedium = UIFont(name: "Avenir-Light", size: 14)!
    static let avenirLightLarge = UIFont(name: "Avenir-Light", size: 18)!
    
    static let avenirItalicSmall = UIFont(name: "Avenir-LightOblique", size: 10)!
    static let avenirItalicMedium = UIFont(name: "Avenir-LightOblique", size: 14)!
    static let avenirItalicLarge = UIFont(name: "Avenir-LightOblique", size: 18)!
    
    static let kohinoorDevanagariRegularSmall = UIFont(name: "KohinoorDevanagari-Regular", size: 10)!
    static let kohinoorDevanagariRegularMedium = UIFont(name: "KohinoorDevanagari-Regular", size: 14)!
    static let kohinoorDevanagariRegularLarge = UIFont(name: "KohinoorDevanagari-Regular", size: 18)!
    
    static let kohinoorDevanagariLightSmall = UIFont(name: "KohinoorDevanagari-Light", size: 10)!
    static let kohinoorDevanagariLightMedium = UIFont(name: "KohinoorDevanagari-Light", size: 14)!
    static let kohinoorDevanagariLightLarge = UIFont(name: "KohinoorDevanagari-Light", size: 18)!
    
    static let kohinoorDevanagariSemiboldSmall = UIFont(name: "KohinoorDevanagari-Semibold", size: 10)!
    static let kohinoorDevanagariSemiboldMedium = UIFont(name: "KohinoorDevanagari-Semibold", size: 14)!
    static let kohinoorDevanagariSemiboldLarge = UIFont(name: "KohinoorDevanagari-Semibold", size: 18)!

    static func availableFonts() {
        for familyName in UIFont.familyNames {
            for font in UIFont.fontNames(forFamilyName: familyName) {
                print(font)
            }
        }
    }
}
