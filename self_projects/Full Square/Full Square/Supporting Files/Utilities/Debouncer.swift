//
//  Debouncer.swift
//  Full Square
//
//  Created by rafaeldelegate on 8/2/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation

class Debouncer {
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    typealias Handler = () -> Void
    
    // Closure  to be debounced
    var handler : Handler?
    
    // Time interval of the debounce window
    private let timeInterval : TimeInterval
    private var timer : Timer?
    
    func renewInterval(){
        // Invalidate existing time if there is one
        timer?.invalidate()
        
        // Begin a new timer from now
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { [weak self] timer in
            self?.handleTimer(timer)
        })
    }
    private func handleTimer(_ timer : Timer){
        guard timer.isValid else {
            return
        }
        handler?()
        handler = nil
    }
}
