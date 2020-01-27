//
//  FileDetailsMapper.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

final class FileDetailsMapper {

    final func map(detailFile: DetailModels.DetailFile) -> FileDetails.ViewModel {
        
        var filesView: [FileDetails.ViewModel.FileItem] = []
        for item in detailFile.items {
            
            var stringDate = ""
            
            let dateFormatter = Formatter.itemDateFormatter
            if let date = item.dateOfBirth {
                stringDate = dateFormatter.string(from: date)
            }
            
            
            let itemView = FileDetails.ViewModel.FileItem(fullName: item.firstName + " " + item.surName,
                                                          issueCount: detailFile.issuesHeader + ": " + item.issues,
                                                          date: detailFile.dateOfBirthHeader + ": " + stringDate)
            filesView.append(itemView)
        }
        
        return FileDetails.ViewModel(isLoading: false,
                                     issues: filesView)
    }
}
