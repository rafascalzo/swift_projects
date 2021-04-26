//
//  Colors.swift
//  Full Square
//
//  Created by rafaeldelegate on 8/24/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit

extension UIColor {
    // MARK: - attributes
    static let backgroundColor = darkRgb(r: 248, g: 248, b: 248)
    
    static let grayColor = darkRgb(r: 243, g: 243, b: 243)
    
    static let whiteColor = darkRgb(r: 253, g: 253, b: 253)
    
    static let blackColor = darkRgb(r: 23, g: 23, b: 23)
    
    static let shadowDarkColor : UIColor = UIColor(white: 0.2, alpha: 0.7)
    //#E7ECED
    static let darkGrayColor = darkRgb(r: 231, g: 236, b: 237)
    //#1081E0
    static let blueColor = darkRgb(r: 16, g: 129, b: 224)
    //D1403F
    static let redColor = darkRgb(r: 209, g: 64, b: 63)
    
    //static let componentGrayColor = darkRgb(r: 223, g: 223, b: 223)
    
    // gray pin ABABAB
    // orange pin FF4107
    static let customSearchBarTextFieldColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
    
    static let defaultButtonColor = UIColor.darkRgb(r: 216, g: 33, b: 20)
    
    static let customSearchBarBackgroundColor = UIColor.lightRgb(r: 50,g: 50,b: 50)
    
    
    //MARK: - Functions
    static func darkRgb (r: CGFloat, g: CGFloat, b:CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static func lightRgb ( r: CGFloat,  g: CGFloat, b:CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 0.75)
    }
    
    static func randomColor() -> UIColor{
        
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
