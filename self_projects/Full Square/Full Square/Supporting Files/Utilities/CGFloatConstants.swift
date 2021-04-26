//
//  CGFloatConstants.swift
//  Full Square
//
//  Created by rafaeldelegate on 7/31/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    static let screenSize:CGSize = UIScreen.main.bounds.size
    
    static let defaultCircularButtonSize: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? CGFloat.screenSize.width * 0.11 : 70
    //  MARK : - MainView Constants
    static let circularButtonSize : CGFloat = CGFloat.screenSize.width * 0.14
    
    static let paddingSmall = UIScreen.main.bounds.width * 0.05
    
    static let paddingLarge = UIScreen.main.bounds.width * 0.07
    
    static let paddingInsideItens = UIScreen.main.bounds.width * 0.025
    
    static let iconWidth = CGFloat.circularButtonSize
    
    static let iconHeight = CGFloat.circularButtonSize
    
    static let iconSpacing = UIScreen.main.bounds.width * 0.05
    
    static let footerHeight = CGFloat.circularButtonSize + 2 * CGFloat.paddingSmall
    
    static let headerGuideForMaps = CGFloat.screenSize.height * 0.12
    
}

