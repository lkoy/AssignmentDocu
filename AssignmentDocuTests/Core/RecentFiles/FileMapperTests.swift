//
//  FileMapperTests.swift
//  AssignmentDocuTests
//
//  Created by Iglesias, Gustavo on 27/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import XCTest
import Nimble

@testable import AssignmentDocu

class FileMapperTests: XCTestCase {

    private var sut: FileMapper!
    
    override func setUp() {
        
        super.setUp()
    }

    override func tearDown() {
        
        sut = nil
        super.tearDown()
    }

    func test_given_files_path_array_then_show_it() {
        sut = FileMapper()
        
        let files = ["/document/issues",
                     "/document/issues2"]
        
        let expected = [FileItemBuilder().with(name: "issues").with(path: "/document/issues").with(kind: .csv).build(),
                        FileItemBuilder().with(name: "issues2").with(path: "/document/issues2").with(kind: .csv).build()]
        
        let result = sut.map(fileItems: files)
        expect(result).to(equal(expected))
    }
    
    func test_given_empty_files_path_array_then_show_it() {
        sut = FileMapper()
        
        let files: [String] = ["",
                               ""]
        
        let expected: [FileModels.FileItem] = []
        
        let result = sut.map(fileItems: files)
        expect(result).to(equal(expected))
    }
    
    func test_given_empty_array_then_show_it() {
        sut = FileMapper()
        
        let files: [String] = []
        
        let expected: [FileModels.FileItem] = []
        
        let result = sut.map(fileItems: files)
        expect(result).to(equal(expected))
    }
}
