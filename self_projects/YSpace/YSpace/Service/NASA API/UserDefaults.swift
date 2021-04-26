//
//  UserDefaults.swift
//  YSpace
//
//  Created by RVSM on 19/03/20.
//  Copyright © 2020 RVSM. All rights reserved.
//

import Foundation

class UserDefaultsManager: NSObject {
    
    static var shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    private let requestQueueKey = "RequestQueueKey"
    
    func getRequestQueue() -> Data? {
        return defaults.object(forKey: requestQueueKey) as? Data
    }
    
    func setRequestQueue(_ requests: Data) {
        defaults.set(requests, forKey: requestQueueKey)
    }
}
