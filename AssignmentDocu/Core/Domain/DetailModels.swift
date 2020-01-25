//
//  CsvModels.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

enum DetailModels {

    struct DetailFile: Codable, Equatable {
        
        
        let firstNameHeader: String
        let surNameHeader: String
        let issuesHeader: String
        let dateOfBirthHeader: String
        let items: [DetailItem]
        
        struct DetailItem: Codable, Equatable {
            
            let firstName: String
            let surName: String
            let issues: String
            let dateOfBirth: Date?
        }
    }
}
