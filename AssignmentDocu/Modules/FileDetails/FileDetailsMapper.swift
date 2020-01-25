//
//  FileDetailsMapper.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

final class FileDetailsMapper {

    final func map(fileTitle: String, detailFile: DetailModels.DetailFile) -> FileDetails.ViewModel {
        
        var filesView: [FileDetails.ViewModel.FileItem] = []
        for item in detailFile.items {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            
            
            let itemView = FileDetails.ViewModel.FileItem(name: item.firstName, surname: item.surName, isueCount: item.issues, date: "TBD")
            filesView.append(itemView)
        }
        
        return FileDetails.ViewModel(screenTitle: fileTitle,
                                     firstNameTitle: detailFile.firstNameHeader,
                                     surNameTitle: detailFile.surNameHeader,
                                     issueCountTitle: detailFile.issuesHeader,
                                     dateTitle: detailFile.dateOfBirthHeader,
                                     issues: filesView)
    }
}
