//
//  Colors.swift
//  Pratical Recipes
//
//  Created by rafaeldelegate on 6/29/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func lightRgb(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor{
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 0.5)
    }
    
    static func darkRgb(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor{
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let pulsatingFillColor = UIColor.lightRgb(r: 255 , g: 0, b: 23)
    
    static let backgroudColor = UIColor.darkRgb(r: 21, g: 22, b: 23)
    
    static let trackStrokeColor = UIColor.darkRgb(r: 112, g: 13, b: 41)
    
    static let outlineStrokeColor = UIColor.darkRgb(r: 210, g: 13, b: 41)
    
    static let facebookBackgroundColor = UIColor.darkRgb(r: 0, g: 96, b: 255)
    
    static let iconsContainerViewBackgroundColor = UIColor.darkRgb(r: 242, g: 248, b: 255)
}
