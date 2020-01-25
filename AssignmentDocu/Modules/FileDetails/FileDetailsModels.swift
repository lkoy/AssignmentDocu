//
//  FileDetailsModels.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

enum FileDetails {

    struct ViewModel: Equatable {
        
        let screenTitle: String
        
        let firstNameTitle: String
        let surNameTitle: String
        let issueCountTitle: String
        let dateTitle: String
        let accounts: [FileItem]
        
        struct FileItem: Equatable {
            let name: String
            let surname: String
            let isueCount: String
            let date: String
        }
    }
}
