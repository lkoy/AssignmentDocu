//
//  FileDetailsInteractorTests.swift
//  AssignmentDocuTests
//
//  Created by Iglesias, Gustavo on 27/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import XCTest
import Nimble

@testable import AssignmentDocu

class FileDetailsInteractorTests: XCTestCase {

    private var sut: FileDetailsInteractor!
    private var presenter: SpyPresenter!
    private var mockReadFileWorker: MockReadFileWorker!
    
    override func setUp() {
        
        super.setUp()
    }

    override func tearDown() {
        
        presenter = nil
        mockReadFileWorker = nil
        sut = nil
        super.tearDown()
    }

    func test_get_recent_files_return_read_file_error_then_call_show_error () {
            
        givenSutWithFileDetailsResult(.failure(.readFileError))
            
        sut.getFileDetailsFromPath("/docs/issues", fileType: .csv)
        
        expect(self.presenter.showErrorCalled).toEventually(equal(1))
        expect(self.presenter.parsedFileCalled).toEventually(equal(0))
        expect(self.presenter.error).toEventually(equal(.readFileError))
    }
    
    func test_get_recent_files_incorrect_headers_return_parse_file_error_then_call_show_error () {
            
        givenSutWithFileDetailsResult(.success("\"First name\",\"Sur name\",\"Issue count\"\r\n\"Theo\",\"Jansen\",5,\"1978-01-02T00:00:00\"\r\n\"Fiona\",\"de Vries\",7,\"1950-11-12T00:00:00\"\r\n\"Petra\",\"Boersma\",1,\"2001-04-20T00:00:00\"\r\n"))
            
        sut.getFileDetailsFromPath("/docs/issues", fileType: .csv)
        
        expect(self.presenter.showErrorCalled).toEventually(equal(1))
        expect(self.presenter.parsedFileCalled).toEventually(equal(0))
        expect(self.presenter.error).toEventually(equal(.parsingFileError))
    }
    
    func test_get_recent_files_incorrect_data_return_parse_file_error_then_call_show_error () {
            
        givenSutWithFileDetailsResult(.success("\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\r\n\"Theo\",\"Jansen\",5,\"1978-01-02T00:00:00\"\r\n\"Fiona\",\"de Vries\",7,\"1950-11-12T00:00:00\"\r\n\"Petra\",\"Boersma\",1\r\n"))
            
        sut.getFileDetailsFromPath("/docs/issues", fileType: .csv)
        
        expect(self.presenter.showErrorCalled).toEventually(equal(1))
        expect(self.presenter.parsedFileCalled).toEventually(equal(0))
        expect(self.presenter.error).toEventually(equal(.parsingFileError))
    }
    
    func test_get_recent_files_empty_data_return_parse_file_error_then_call_show_error () {
            
        givenSutWithFileDetailsResult(.success(""))
            
        sut.getFileDetailsFromPath("/docs/issues", fileType: .csv)
        
        expect(self.presenter.showErrorCalled).toEventually(equal(1))
        expect(self.presenter.parsedFileCalled).toEventually(equal(0))
        expect(self.presenter.error).toEventually(equal(.parsingFileError))
    }
    
    func test_get_recent_files_then_parsed_file () {
        
        let expectedModel = DetailFileBuilder()
        .with(issuesHeader: "Issue count")
        .with(surNameHeader: "Sur name")
        .with(firstNameHeader: "First name")
        .with(dateOfBirthHeader: "Date of birth")
        .with(items: [DetailItemBuilder().with(dateOfBirth: "1978-01-02T00:00:00".toDate()!).with(firstName: "Theo").with(surName: "Jansen").with(issues: "5").build(),
                      DetailItemBuilder().with(dateOfBirth: "1950-11-12T00:00:00".toDate()!).with(firstName: "Fiona").with(surName: "de Vries").with(issues: "7").build(),
                      DetailItemBuilder().with(dateOfBirth: "2001-04-20T00:00:00".toDate()!).with(firstName: "Petra").with(surName: "Boersma").with(issues: "1").build()])
        .build()
        
        givenSutWithFileDetailsResult(.success("\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\r\n\"Theo\",\"Jansen\",5,\"1978-01-02T00:00:00\"\r\n\"Fiona\",\"de Vries\",7,\"1950-11-12T00:00:00\"\r\n\"Petra\",\"Boersma\",1,\"2001-04-20T00:00:00\"\r\n"))
            
        sut.getFileDetailsFromPath("/docs/issues", fileType: .csv)
        
        expect(self.presenter.showErrorCalled).toEventually(equal(0))
        expect(self.presenter.parsedFileCalled).toEventually(equal(1))
        expect(self.presenter.filesFound).toEventually(equal(expectedModel))
    }
    
    private func givenSutWithFileDetailsResult(_ readFileResult: Result<String, ReadFileWorkerError>) {
        
        presenter = SpyPresenter()
        mockReadFileWorker = MockReadFileWorker(result: readFileResult)
        
        sut = FileDetailsInteractor(withReadFileWorker: mockReadFileWorker, parseCsvFileWorker: ParseCsvFileWorker())

        sut.presenter = presenter
    }
}

private class SpyPresenter: FileDetailsInteractorCallbackProtocol {
    
    var parsedFileCalled: Int = 0
    var showErrorCalled: Int = 0
    
    var filesFound: DetailModels.DetailFile?
    var error: FileDetailsInteractorError?
    
    func parsedFile(_ parsed: DetailModels.DetailFile) {
        
        parsedFileCalled += 1
        filesFound = parsed
    }
    
    func showError(error: FileDetailsInteractorError) {
        
        showErrorCalled += 1
        self.error = error
    }
}

private class MockReadFileWorker: ReadFileWorkerAlias {
    
    var result: Result<String, ReadFileWorkerError>
    
    init(result: Result<String, ReadFileWorkerError>) {
        self.result = result
    }
    
    override func job(input: String, completion: @escaping ((Result<String, ReadFileWorkerError>) -> Void)) {
        completion(result)
    }
}
