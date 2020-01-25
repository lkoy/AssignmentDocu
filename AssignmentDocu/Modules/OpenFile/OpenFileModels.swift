//
//  OpenFileModels.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 23/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation
import UIKit.UIImage

enum OpenFile {

    struct ViewModel: Equatable {
        
        let isLoading: Bool
        let files: [CsvFile]
        
        struct CsvFile: Equatable {
            let name: String
            let image: UIImage?
        }
    }
}
