//
//  AppIconService.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/19/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class AppIconService {
    
    let application = UIApplication.shared
    
    enum AppIcon: String {
        case primaryAppIcon
    }
    
    func changeAppIcon(to appIcon: AppIcon){
        application.setAlternateIconName(appIcon.rawValue)
        
    }
}
