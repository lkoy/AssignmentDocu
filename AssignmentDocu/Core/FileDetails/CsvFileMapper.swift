//
//  CsvFileMapper.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

enum CsvFileMapperError: Error {
    case incorrectFormatError
}

class CsvFileMapper {
    
    final func map(csvFileItems: [[String]]) throws -> DetailModels.DetailFile{
        guard !csvFileItems.isEmpty else {
            throw CsvFileMapperError.incorrectFormatError
        }
        
        var csvItems: [DetailModels.DetailFile.DetailItem] = []
        
        let firstItem = csvFileItems.first
        
        guard firstItem?.count == 4 else {
            throw CsvFileMapperError.incorrectFormatError
        }
        
        var arrayCsvItems = csvFileItems
        arrayCsvItems.remove(at: 0)
        
        try arrayCsvItems.forEach { (file) in
            
            csvItems.append(try map(csvItem: file))
        }
        
        return DetailModels.DetailFile(firstNameHeader: firstItem?[0] ?? "",
                                       surNameHeader: firstItem?[1] ?? "",
                                       issuesHeader: firstItem?[2] ?? "",
                                       dateOfBirthHeader: firstItem?[3] ?? "",
                                       items: csvItems)
    }
    
    final func map(csvItem: [String]) throws -> DetailModels.DetailFile.DetailItem {

        guard csvItem.count == 4 else {
            throw CsvFileMapperError.incorrectFormatError
        }
        
        return DetailModels.DetailFile.DetailItem(firstName: csvItem[0] , surName: csvItem[1] , issues: csvItem[2] , dateOfBirth: csvItem[3].toDate())
    }
}
