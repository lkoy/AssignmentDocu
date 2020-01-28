//
//  ReadFileWorkerTests.swift
//  AssignmentDocuTests
//
//  Created by Iglesias, Gustavo on 28/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import XCTest
import Nimble

@testable import AssignmentDocu

class ReadFileWorkerTests: XCTestCase {

    private var sut: ReadFileWorker!
    
    override func setUp() {
        
        super.setUp()
    }

    override func tearDown() {
        
        sut = nil
        super.tearDown()
    }

    func test_given_dont_exist_file_then_no_file_error() {
        
        var defaultPaymentError: ReadFileWorkerError?
        
        sut = ReadFileWorker()
        
        sut.execute(input: "Test_Empty") { (result) in
            switch result {
            case .success:
                XCTFail("Should not exist file")
            case .failure(let error):
                defaultPaymentError = error
            }
        }
        
        expect(defaultPaymentError).toEventually(matchError(ReadFileWorkerError.readFileError))
    }
}
