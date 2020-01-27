//
//  GetRecentFilesInteractorTests.swift
//  AssignmentDocuTests
//
//  Created by Iglesias, Gustavo on 27/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import XCTest
import Nimble

@testable import AssignmentDocu

class GetRecentFilesInteractorTests: XCTestCase {

    private var sut: GetRecentFilesInteractor!
    private var presenter: SpyPresenter!
    private var mockRecentFilesWorker: MockRecentFilesWorker!
    
    override func setUp() {
        
        super.setUp()
    }

    override func tearDown() {
        
        presenter = nil
        mockRecentFilesWorker = nil
        sut = nil
        super.tearDown()
    }

    func test_get_recent_files_return_succes_then_found_called_with_data () {
            
        givenSutWithFileItemsResult(.success([FileItemBuilder().build()]))
            
        sut.getRecentFiles()
        
        expect(self.presenter.filesFoundCalled).toEventually(equal(1))
        expect(self.presenter.filesFound).toEventually(equal([FileItemBuilder().build()]))
    }
    
    func test_get_recent_files_return_succes_then_found_called_without_data () {
            
        givenSutWithFileItemsResult(.failure(.getRecentFilesError))
            
        sut.getRecentFiles()
        
        expect(self.presenter.filesFoundCalled).toEventually(equal(1))
        expect(self.presenter.filesFound).toEventually(equal([]))
    }
    
    private func givenSutWithFileItemsResult(_ fileItems: Result<[FileModels.FileItem], GetRecentFilesWorkerError>) {
        
        presenter = SpyPresenter()
        mockRecentFilesWorker = MockRecentFilesWorker(result: fileItems)
        
        sut = GetRecentFilesInteractor(withGetRecentFilesWorker: mockRecentFilesWorker)

        sut.presenter = presenter
    }
}

private class SpyPresenter: GetRecentFilesInteractorCallbackProtocol {
    
    var filesFoundCalled: Int = 0
    
    var filesFound: [FileModels.FileItem]?
    
    func filesFound(files: [FileModels.FileItem]) {
        
        filesFoundCalled += 1
        filesFound = files
    }
}

private class MockRecentFilesWorker: GetRecentFilesWorkerAlias {
    
    var result: Result<[FileModels.FileItem], GetRecentFilesWorkerError>
    
    init(result: Result<[FileModels.FileItem], GetRecentFilesWorkerError>) {
        self.result = result
    }
    
    override func job(input: String, completion: @escaping ((Result<[FileModels.FileItem], GetRecentFilesWorkerError>) -> Void)) {
        completion(result)
    }
}
