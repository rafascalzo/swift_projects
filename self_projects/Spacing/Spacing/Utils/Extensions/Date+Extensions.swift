//
//  Date+Extensions.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

enum DateFormat {
    
    case yearMonthDay, dayMonthYear
    
    func value() -> String {
        switch self {
        case .yearMonthDay: return "yyyy-MM-dd"
        case .dayMonthYear: return "dd-MM-yyy"
        }
    }
}

extension Date {
    
    static func stringValue(from date: Date, pattern: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = pattern.value()
        return formatter.string(from: date)
    }
}
