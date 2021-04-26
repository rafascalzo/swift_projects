//
//  Validation.swift
//  Full Square
//
//  Created by rafaeldelegate on 8/27/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

enum textFieldType : Int {
    case category = 1
    case placeName = 2
    case site = 3
    case adress = 4
    case number = 5
}

open class Validation : NSObject {
    
    static func isTextFieldsEmpty(textFields:Array<UITextField>) -> Bool {
        
        var isTextFieldsFilled = true
        
        for textField in textFields {
            if textField.text == "" || textField.text  == "Click to select category" {
                isTextFieldsFilled = false
                return false
            }
        }
        return isTextFieldsFilled
    }
    
    static func isValidPinName(_ name : String ) -> Bool{
        
        let pins = PinDAO().retrievePins().filter() {$0.name?.uppercased() == name.uppercased()}
        
        return pins.count == 0
    }
    static func isValidEmail(_ email:String) -> Bool {
                let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
                let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
                return emailTest.evaluate(with: email)
    }
    
    static func isValidTelephone(_ telephone: String) -> Bool {
        let phoneRegEx = "^((\\+)|(00))[0-9]{6,14}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phonePredicate.evaluate(with:telephone)
    }
    static func isValidUrl(_ url:String) -> Bool {
        return url.hasPrefix("http://www.")
//        let urlRegEx = "(?i)https?:\/\/[[:word:]]+(?:\.[[:word:]]+)+"
//        let urlPredicate = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
//        return urlPredicate.evaluate(with: url)
    }
    
}

