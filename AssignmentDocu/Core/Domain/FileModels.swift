//
//  FileModels.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

enum FileModels {

    struct FileItem: Codable, Equatable {
        
        let path: String
        let kind: Kind
        
        enum Kind: String, Equatable, Codable, CaseIterable {
            case csv
        }
    }
}

extension FileModels.FileItem.Kind {
    
    var image: String {
        switch self {
        case .csv:
            return "csv_icon"
       }
    }
}
