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
        
        let isLoading: Bool
        
        let issueCountTitle: String
        let dateTitle: String
        let issues: [FileItem]
        
        struct FileItem: Equatable {
            let fullName: String
            let issueCount: String
            let date: String
        }
    }
}
