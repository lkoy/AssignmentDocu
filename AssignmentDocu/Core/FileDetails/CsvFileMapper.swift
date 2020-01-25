//
//  CsvFileMapper.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

class CsvFileMapper {
    
    final func map(csvFileItems: [[String]]) -> DetailModels.DetailFile {
        guard !csvFileItems.isEmpty else {
            return DetailModels.DetailFile(firstNameHeader: "", surNameHeader: "", issuesHeader: "", dateOfBirthHeader: "", items: [])
        }
        
        var csvItems: [DetailModels.DetailFile.DetailItem] = []
        
        let firstItem = csvFileItems.first
        var arrayCsvItems = csvFileItems
        arrayCsvItems.remove(at: 0)
        
        arrayCsvItems.forEach { (file) in
            guard let mapped = map(csvItem: file) else {
                return
            }
            csvItems.append(mapped)
        }
        
        if firstItem?.count == 4 {
            return DetailModels.DetailFile(firstNameHeader: firstItem?[0] ?? "",
            surNameHeader: firstItem?[1] ?? "",
            issuesHeader: firstItem?[2] ?? "",
            dateOfBirthHeader: firstItem?[3] ?? "",
            items: csvItems)
        }
        
        return DetailModels.DetailFile(firstNameHeader: "", surNameHeader: "", issuesHeader: "", dateOfBirthHeader: "", items: csvItems)
    }
    
    final func map(csvItem: [String]) -> DetailModels.DetailFile.DetailItem? {

        guard csvItem.count == 4 else {
            return nil
        }
        
        return DetailModels.DetailFile.DetailItem(firstName: csvItem[0] , surName: csvItem[1] , issues: csvItem[2] , dateOfBirth: csvItem[3].toDate())
    }
}
