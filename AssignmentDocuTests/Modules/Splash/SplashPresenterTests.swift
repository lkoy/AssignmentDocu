//
//  SplashPresenterTests.swift
//  AssignmentDocuTests
//
//  Created by Iglesias, Gustavo on 27/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import XCTest
import Nimble

@testable import AssignmentDocu

class SplashPresenterTests: XCTestCase {

    private var sut: SplashPresenter<ViewControllerSpy, RouterSpy>!
    private var viewControllerSpy: ViewControllerSpy!
    private var splashInteractor: MockSplashInteractor!
    private var routerSpy: RouterSpy!
    
    override func setUp() {
        
        super.setUp()
        sut = givenSut()
    }

    override func tearDown() {
        
        viewControllerSpy = nil
        routerSpy = nil
        splashInteractor = nil
        sut = nil
        super.tearDown()
    }

    func test_bundle_files_found_then_navigate_select_file() {
        
        splashInteractor.stubGetRecentFilesFor(self.sut.filesFound(files: []))
            
        sut.getInitDetails()
        expect(self.routerSpy.navigateToOpenFilesCalled).toEventually(equal(1))
    }
    
    private func givenSut() -> SplashPresenter<ViewControllerSpy, RouterSpy> {
        viewControllerSpy = ViewControllerSpy()
        routerSpy = RouterSpy()
        splashInteractor = MockSplashInteractor()
        
        let sut = SplashPresenter(viewController: viewControllerSpy, router: routerSpy, getRecentFilesInteractor: splashInteractor)

        return sut
    }
}

private class ViewControllerSpy: SplashViewControllerProtocol {

}

private class RouterSpy: SplashRouterProtocol {
    
    var navigateToOpenFilesCalled: Int = 0
    
    func navigateToOpenFiles(withFiles files: [FileModels.FileItem]) {
        
        navigateToOpenFilesCalled += 1
    }
}

private class MockSplashInteractor: GetRecentFilesInteractorProtocol {
    
    var getRecentFilesFunction: (() -> Void)!

    func stubGetRecentFilesFor(_ f: @autoclosure @escaping (() -> Void)) {
        self.getRecentFilesFunction = f
    }
    
    func getRecentFiles() {
        
        getRecentFilesFunction()
    }
}
