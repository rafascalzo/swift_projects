//
//  String+Extensions.swift
//  YSpace
//
//  Created by RVSM on 22/03/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value:"", comment: "")
    }
}
