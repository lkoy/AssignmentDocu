//
//  Formatter+Csv.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

extension Formatter {

    static let csvDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss'Z"
        formatter.timeZone = .current
        return formatter
    }()
}
