//
//  Date+ISO8601.swift
//  Marvel
//
//  Created by rafael-estagio on 17/07/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation

extension Date {
    init?(ISO8601: String) {
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: ISO8601) else { return nil }
        self = date
    }
}
