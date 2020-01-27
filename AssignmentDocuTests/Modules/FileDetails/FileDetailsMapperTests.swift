//
//  FileDetailsMapperTests.swift
//  AssignmentDocuTests
//
//  Created by Iglesias, Gustavo on 27/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import XCTest
import Nimble

@testable import AssignmentDocu

class FileDetailsMapperTests: XCTestCase {

    private var sut: FileDetailsMapper!
    
    override func setUp() {
        
        super.setUp()
    }

    override func tearDown() {
        
        sut = nil
        super.tearDown()
    }

    func test_given_file_details_then_show_it() {
        
        sut = FileDetailsMapper()
        
        let dateOneDayFromToday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let item = DetailItemBuilder().with(issues: "3")
            .with(surName: "Perez")
            .with(firstName: "Paco")
            .with(dateOfBirth: dateOneDayFromToday)
            .build()
        
        let fileDetails = DetailFileBuilder().with(issuesHeader: "")
            .with(surNameHeader: "Surname")
            .with(firstNameHeader: "Name")
            .with(dateOfBirthHeader: "Birth")
            .with(issuesHeader: "Issues")
            .with(items: [item])
            .build()
        
        let dateResult = Formatter.itemDateFormatter.string(from: item.dateOfBirth!)
        let expected = FileDetails.ViewModel(isLoading: false, issues: [FileDetails.ViewModel.FileItem(fullName: "Paco Perez",
                                                                                     issueCount: "Issues: 3",
                                                                                     date: "Birth: " + dateResult)])
        
        let result = sut.map(detailFile: fileDetails)
        expect(result).to(equal(expected))
    }
    
    func test_given_no_file_details_items_then_show_it() {
        
        sut = FileDetailsMapper()
        
        let fileDetails = DetailFileBuilder().with(issuesHeader: "")
            .with(surNameHeader: "Surname")
            .with(firstNameHeader: "Name")
            .with(dateOfBirthHeader: "Birth")
            .with(issuesHeader: "Issues")
            .with(items: [])
            .build()
        
        let expected = FileDetails.ViewModel(isLoading: false,
                                             issues: [])
        
        let result = sut.map(detailFile: fileDetails)
        expect(result).to(equal(expected))
    }
}
