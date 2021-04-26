//
//  LocalAuthentication.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 16/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit
import LocalAuthentication

class LocalAuthentication: NSObject {
    
    var error : NSError?
    let reason = "Necessary auth to delete or another other reason"
    
    func authorizeUser(completion : @escaping (_ authorized : Bool) -> Void){
        
        let context = LAContext()
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication , error: &error) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: reason) { (response, error) in
                
                completion(response)
            }
        }
    }

}
