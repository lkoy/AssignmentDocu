//
//  OpenFileMapperTests.swift
//  AssignmentDocuTests
//
//  Created by Iglesias, Gustavo on 27/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import XCTest
import Nimble

@testable import AssignmentDocu

class OpenFileMapperTests: XCTestCase {
    
    private var sut: OpenFileMapper!

    override func setUp() {
        
        super.setUp()
    }

    override func tearDown() {
        
        sut = nil
        super.tearDown()
    }

    func test_given_no_document_then_show_it() {
        sut = OpenFileMapper()
        
        let files: [FileModels.FileItem] = []
        
        let expected = OpenFile.ViewModel(isLoading: false, files: [])
        
        let result = sut.map(files: files)
        expect(result).to(equal(expected))
    }
    
    func test_given_one_document_then_show_it() {
        sut = OpenFileMapper()
        
        let files = [FileItemBuilder().with(name: "issues_all")
            .with(path: "documents/issues/issues_all")
            .build()]
        
        let expected = OpenFile.ViewModel(isLoading: false, files: [OpenFile.ViewModel.CsvFile(name: "issues_all",
                                                                                               image: UIImage(named: "csv_icon"))])
        
        let result = sut.map(files: files)
        expect(result).to(equal(expected))
    }
    
    func test_given_more_than_one_document_then_show_it() {
        sut = OpenFileMapper()
        
        let files = [FileItemBuilder().with(name: "issues_all")
            .with(path: "documents/issues/issues_all")
            .build(), FileItemBuilder().with(name: "issues")
                        .with(path: "documents/issues/issues")
                        .build()]
        
        let expected = OpenFile.ViewModel(isLoading: false, files: [OpenFile.ViewModel.CsvFile(name: "issues_all",
                                                                                               image: UIImage(named: "csv_icon")),
                                                                    OpenFile.ViewModel.CsvFile(name: "issues",
                                                                                               image: UIImage(named: "csv_icon"))])
        
        let result = sut.map(files: files)
        expect(result).to(equal(expected))
    }
}
