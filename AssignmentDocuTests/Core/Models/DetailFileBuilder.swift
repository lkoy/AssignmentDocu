//
//  DetailFileBuilder.swift
//  AssignmentDocuTests
//
//  Created by Iglesias, Gustavo on 27/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation
@testable import AssignmentDocu

final class DetailFileBuilder {
    
    private var firstNameHeader: String = "First name"
    private var surNameHeader: String = "Sur name"
    private var issuesHeader: String = "Issue count"
    private var dateOfBirthHeader: String = "Date of birth"
    private var items: [DetailModels.DetailFile.DetailItem] = []

    func with(firstNameHeader: String) -> DetailFileBuilder {
        
        self.firstNameHeader = firstNameHeader
        return self
    }
    
    func with(surNameHeader: String) -> DetailFileBuilder {
        
        self.surNameHeader = surNameHeader
        return self
    }
    
    func with(issuesHeader: String) -> DetailFileBuilder {
        
        self.issuesHeader = issuesHeader
        return self
    }
    
    func with(dateOfBirthHeader: String) -> DetailFileBuilder {
        
        self.dateOfBirthHeader = dateOfBirthHeader
        return self
    }
    
    func with(items: [DetailModels.DetailFile.DetailItem]) -> DetailFileBuilder {
        
        self.items = items
        return self
    }
    
    func build() -> DetailModels.DetailFile {
        
        return DetailModels.DetailFile(firstNameHeader: firstNameHeader,
                                       surNameHeader: surNameHeader,
                                       issuesHeader: issuesHeader,
                                       dateOfBirthHeader: dateOfBirthHeader,
                                       items: items)
    }
    
}
