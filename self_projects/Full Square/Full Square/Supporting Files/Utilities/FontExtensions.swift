//
//  FontExtensions.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 09/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    static let titleSmallFont = UIFont(name: "Sansation-Light", size: UIDevice.currentDevice == .phone ? 12 : 24)
    static let titleMediumFont = UIFont(name: "Sansation-Light", size: UIDevice.currentDevice == .phone ? 16 : 32)
    static let tittleLargeFont = UIFont(name: "Sansation-Light", size: UIDevice.currentDevice == .phone ? 20 : 40)
    static let tittleExtraLargeFont = UIFont(name: "Sansation-Light", size: UIDevice.currentDevice == .phone ? 40 : 80)
    
    static let textSmallFont = UIFont(name: "Cabin-Regular", size: UIDevice.currentDevice == .phone ? 12 : 24)
    static let textMediumFont = UIFont(name: "Cabin-Regular", size: UIDevice.currentDevice == .phone ? 16 : 32)
    static let textLargeFont = UIFont(name: "Cabin-Regular", size: UIDevice.currentDevice == .phone ? 20 : 40)
    
   
}
