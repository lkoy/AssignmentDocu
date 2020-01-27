//
//  DetailItemBuilder.swift
//  AssignmentDocuTests
//
//  Created by Iglesias, Gustavo on 27/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation
@testable import AssignmentDocu

final class DetailItemBuilder {
    
    private var firstName: String = "Theo"
    private var surName: String = "Jansen"
    private var issues: String = "5"
    private var dateOfBirth: Date? = Date()

    func with(firstName: String) -> DetailItemBuilder {
        self.firstName = firstName
        return self
    }
    
    func with(surName: String) -> DetailItemBuilder {
        self.surName = surName
        return self
    }
    
    func with(issues: String) -> DetailItemBuilder {
        self.issues = issues
        return self
    }
    
    func with(dateOfBirth: Date) -> DetailItemBuilder {
        self.dateOfBirth = dateOfBirth
        return self
    }
    
    func build() -> DetailModels.DetailFile.DetailItem {
        return DetailModels.DetailFile.DetailItem(firstName: firstName,
                                                  surName: surName,
                                                  issues: issues,
                                                  dateOfBirth: dateOfBirth)
    }
    
}
