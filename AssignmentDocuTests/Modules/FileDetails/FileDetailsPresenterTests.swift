//
//  FileDetailsPresenterTests.swift
//  AssignmentDocuTests
//
//  Created by Iglesias, Gustavo on 27/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import XCTest
import Nimble

@testable import AssignmentDocu

class FileDetailsPresenterTests: XCTestCase {
    
    private var sut: FileDetailsPresenter<ViewControllerSpy, RouterSpy>!
    private var viewControllerSpy: ViewControllerSpy!
    private var fileDetailsInteractor: MockFileDetailsInteractor!
    private var routerSpy: RouterSpy!

    override func setUp() {
        
        super.setUp()
        sut = givenSut()
    }

    override func tearDown() {
        
        viewControllerSpy = nil
        fileDetailsInteractor = nil
        routerSpy = nil
        sut = nil
        super.tearDown()
    }

    func test_when_prepareview_called_with_items_then_screen_is_setup() {
        
        fileDetailsInteractor.stubGetFileDetailsFromPathFunctionFor(self.sut.parsedFile(DetailFileBuilder().with(items: [DetailItemBuilder().build()]).build()))
        
        sut.prepareView()
        
        expect(self.viewControllerSpy.setTitleCalled).toEventually(equal(1))
        expect(self.viewControllerSpy.showCalled).toEventually(equal(1))
        expect(self.viewControllerSpy.showErrorAlertCalled).toEventually(equal(0))
        expect(self.viewControllerSpy.showEmptyStateCalled).toEventually(equal(0))
    }
    
    func test_when_prepareview_called_with_no_items_then_screen_is_setup() {
        
        fileDetailsInteractor.stubGetFileDetailsFromPathFunctionFor(self.sut.parsedFile(DetailFileBuilder().build()))
        
        sut.prepareView()
        
        expect(self.viewControllerSpy.setTitleCalled).toEventually(equal(1))
        expect(self.viewControllerSpy.showEmptyStateCalled).toEventually(equal(1))
        expect(self.viewControllerSpy.showErrorAlertCalled).toEventually(equal(0))
        expect(self.viewControllerSpy.showCalled).toEventually(equal(0))
    }
    
    func test_when_prepareview_called_with_error_called_show_parsing_error() {
        
        fileDetailsInteractor.stubGetFileDetailsFromPathFunctionFor(self.sut.showError(error: .parsingFileError))
        
        sut.prepareView()
        
        expect(self.viewControllerSpy.setTitleCalled).toEventually(equal(1))
        expect(self.viewControllerSpy.showErrorAlertCalled).toEventually(equal(1))
        expect(self.viewControllerSpy.alertMessage).toEventually(equal("File format incorrect"))
        expect(self.viewControllerSpy.showCalled).toEventually(equal(0))
        expect(self.viewControllerSpy.showEmptyStateCalled).toEventually(equal(0))
    }
    
    func test_when_prepareview_called_with_error_called_show_reading_error() {
        
        fileDetailsInteractor.stubGetFileDetailsFromPathFunctionFor(self.sut.showError(error: .readFileError))
        
        sut.prepareView()
        
        expect(self.viewControllerSpy.setTitleCalled).toEventually(equal(1))
        expect(self.viewControllerSpy.showErrorAlertCalled).toEventually(equal(1))
        expect(self.viewControllerSpy.alertMessage).toEventually(equal("Reading file error"))
        expect(self.viewControllerSpy.showCalled).toEventually(equal(0))
        expect(self.viewControllerSpy.showEmptyStateCalled).toEventually(equal(0))
    }
    
    private func givenSut() -> FileDetailsPresenter<ViewControllerSpy, RouterSpy> {
        viewControllerSpy = ViewControllerSpy()
        routerSpy = RouterSpy()
        fileDetailsInteractor = MockFileDetailsInteractor()
        
        let sut = FileDetailsPresenter(viewController: viewControllerSpy,
                                       router: routerSpy,
                                       file: FileItemBuilder().with(name: "issues_all")
                                        .with(path: "documents/issues/issues_all")
                                        .build(),
                                       getFileDetailsInteractor: fileDetailsInteractor,
                                       fileDetailsMapper: FileDetailsMapper())

        return sut
    }
}

private class ViewControllerSpy: FileDetailsViewControllerProtocol {
    
    var showCalled: Int = 0
    var setTitleCalled: Int = 0
    var showEmptyStateCalled: Int = 0
    var showErrorAlertCalled: Int = 0
    
    var alertMessage: String?
    
    func show(_ viewModel: FileDetails.ViewModel) {
        
        showCalled += 1
    }
    
    func setTitle(_ title: String) {
        
        setTitleCalled += 1
    }
    
    func showEmptyState() {
        
        showEmptyStateCalled += 1
    }
    
    func showErrorAlert(message: String, handler: @escaping ((UIAlertAction) -> Void)) {
        
        alertMessage = message
        showErrorAlertCalled += 1
    }
}

private class RouterSpy: FileDetailsRouterProtocol {
    
}

private class MockFileDetailsInteractor: FileDetailsInteractorProtocol {
    
    var getFileDetailsFromPathFunction: (() -> Void)!

    func stubGetFileDetailsFromPathFunctionFor(_ f: @autoclosure @escaping (() -> Void)) {
        self.getFileDetailsFromPathFunction = f
    }
    
    func getFileDetailsFromPath(_ path: String, fileType: FileModels.FileItem.Kind) {
        
        getFileDetailsFromPathFunction()
    }
}
