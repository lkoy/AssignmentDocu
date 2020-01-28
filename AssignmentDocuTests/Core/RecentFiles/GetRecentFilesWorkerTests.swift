//
//  GetRecentFilesWorkerTests.swift
//  AssignmentDocuTests
//
//  Created by Iglesias, Gustavo on 27/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import XCTest
import Nimble

@testable import AssignmentDocu

class GetRecentFilesWorkerTests: XCTestCase {

    private var sut: GetRecentFilesWorker!
    
    override func setUp() {
        
        super.setUp()
    }

    override func tearDown() {
        
        sut = nil
        super.tearDown()
    }

    func test_given_empty_bundle_then_empty_list() {
        
        var bundleFiles: [FileModels.FileItem] = []
        
        sut = GetRecentFilesWorker(mapper: FileMapper())
        
        sut.execute(input: "Test_Empty") { (result) in
            switch result {
            case .success(let filesList):
                bundleFiles = filesList
            case .failure:
                XCTFail("Should return list")
            }
        }
        
        expect(bundleFiles).toEventually(equal([]))
    }
    
    func test_given_no_bundle_then_empty_list() {
        
        var bundleFiles: [FileModels.FileItem] = []
        
        sut = GetRecentFilesWorker(mapper: FileMapper())
        
        sut.execute(input: "Test") { (result) in
            switch result {
            case .success(let filesList):
                bundleFiles = filesList
            case .failure:
                XCTFail("Should return list")
            }
        }
        
        expect(bundleFiles).toEventually(equal([]))
    }
    
    func test_given_bundle_with_one_file_then_file_list() {
        
        var bundleFiles: [FileModels.FileItem] = []
        
        sut = GetRecentFilesWorker(mapper: FileMapper())
        
        sut.execute(input: "Test_with_files") { (result) in
            switch result {
            case .success(let filesList):
                bundleFiles = filesList
            case .failure:
                XCTFail("Should return list")
            }
        }
        
        expect(bundleFiles.count).toEventually(equal(2))
    }
}
