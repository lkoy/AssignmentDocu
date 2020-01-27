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
    private var mockParseCsvFileWorker: MockParseCsvFileWorker!
    
    override func setUp() {
        
        super.setUp()
    }

    override func tearDown() {
        
        presenter = nil
        mockReadFileWorker = nil
        mockParseCsvFileWorker = nil
        sut = nil
        super.tearDown()
    }

    func test_get_recent_files_return_read_file_error_then_call_show_error () {
            
        givenSutWithFileDetailsResult(.failure(.readFileError), parseCsvFileResult: .failure(.parsingFileError))
            
        sut.getFileDetailsFromPath("/docs/issues", fileType: .csv)
        
        expect(self.presenter.showErrorCalled).toEventually(equal(1))
        expect(self.presenter.parsedFileCalled).toEventually(equal(0))
        expect(self.presenter.error).toEventually(equal(.readFileError))
    }
    
    func test_get_recent_files_return_parse_file_error_then_call_show_error () {
            
        givenSutWithFileDetailsResult(.success("\"First name\",\"Sur name\",\"Issue count\"\r\n\"Theo\",\"Jansen\",5,\"1978-01-02T00:00:00\"\r\n\"Fiona\",\"de Vries\",7,\"1950-11-12T00:00:00\"\r\n\"Petra\",\"Boersma\",1,\"2001-04-20T00:00:00\"\r\n"), parseCsvFileResult: .failure(.parsingFileError))
            
        sut.getFileDetailsFromPath("/docs/issues", fileType: .csv)
        
        expect(self.presenter.showErrorCalled).toEventually(equal(1))
        expect(self.presenter.parsedFileCalled).toEventually(equal(0))
        expect(self.presenter.error).toEventually(equal(.parsingFileError))
    }
    
    func test_get_recent_files_then_parsed_file () {
        
        let expectedModel = DetailFileBuilder()
        .with(issuesHeader: "Issue count")
        .with(surNameHeader: "Issue count")
        .with(firstNameHeader: "Issue count")
        .with(dateOfBirthHeader: "Issue count")
        .with(items: [DetailItemBuilder().with(dateOfBirth: "1978-01-02T00:00:00".toDate()!).with(firstName: "Theo").with(surName: "Jansen").with(issues: "5").build(),
                      DetailItemBuilder().with(dateOfBirth: "1950-11-12T00:00:00".toDate()!).with(firstName: "Fiona").with(surName: "de Vries").with(issues: "7").build(),
                      DetailItemBuilder().with(dateOfBirth: "2001-04-20T00:00:00".toDate()!).with(firstName: "Petra").with(surName: "Boersma").with(issues: "1").build()])
        .build()
        
        givenSutWithFileDetailsResult(.success("\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\r\n\"Theo\",\"Jansen\",5,\"1978-01-02T00:00:00\"\r\n\"Fiona\",\"de Vries\",7,\"1950-11-12T00:00:00\"\r\n\"Petra\",\"Boersma\",1,\"2001-04-20T00:00:00\"\r\n"), parseCsvFileResult: .success(expectedModel))
            
        sut.getFileDetailsFromPath("/docs/issues", fileType: .csv)
        
        expect(self.presenter.showErrorCalled).toEventually(equal(0))
        expect(self.presenter.parsedFileCalled).toEventually(equal(1))
        expect(self.presenter.filesFound).toEventually(equal(expectedModel))
    }
    
    private func givenSutWithFileDetailsResult(_ readFileResult: Result<String, ReadFileWorkerError>, parseCsvFileResult: Result<DetailModels.DetailFile, ParseCsvFileWorkerError>) {
        
        presenter = SpyPresenter()
        mockReadFileWorker = MockReadFileWorker(result: readFileResult)
        mockParseCsvFileWorker = MockParseCsvFileWorker(result: parseCsvFileResult)
        
        sut = FileDetailsInteractor(withReadFileWorker: mockReadFileWorker, parseCsvFileWorker: mockParseCsvFileWorker)

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

private class MockParseCsvFileWorker: ParseCsvFileWorkerAlias {
    
    var result: Result<DetailModels.DetailFile, ParseCsvFileWorkerError>
    
    init(result: Result<DetailModels.DetailFile, ParseCsvFileWorkerError>) {
        self.result = result
    }
    
    override func job(input: String, completion: @escaping (Result<DetailModels.DetailFile, ParseCsvFileWorkerError>) -> Void) {
        completion(result)
    }
}
