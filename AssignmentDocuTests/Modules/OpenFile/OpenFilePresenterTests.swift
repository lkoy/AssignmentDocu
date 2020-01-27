//
//  OpenFilePresenterTests.swift
//  AssignmentDocuTests
//
//  Created by Iglesias, Gustavo on 27/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import XCTest
import Nimble

@testable import AssignmentDocu

class OpenFilePresenterTests: XCTestCase {

    private var sut: OpenFilePresenter<ViewControllerSpy, RouterSpy>!
    private var viewControllerSpy: ViewControllerSpy!
    private var routerSpy: RouterSpy!
    
    override func setUp() {
        
        super.setUp()
        sut = givenSut()
    }

    override func tearDown() {
        
        viewControllerSpy = nil
        routerSpy = nil
        sut = nil
        super.tearDown()
    }

    func test_when_prepareview_called_then_screen_is_setup() {
        
        sut.prepareView()
        
        expect(self.viewControllerSpy.navigateToShowCalled).toEventually(equal(1))
    }
    
    private func givenSut() -> OpenFilePresenter<ViewControllerSpy, RouterSpy> {
        viewControllerSpy = ViewControllerSpy()
        routerSpy = RouterSpy()
        
        let sut = OpenFilePresenter(viewController: viewControllerSpy, router: routerSpy, fileItems: [], fileMapper: OpenFileMapper())

        return sut
    }
}

private class ViewControllerSpy: OpenFileViewControllerProtocol{
    
    var navigateToShowCalled: Int = 0
    
    func show(_ viewModel: OpenFile.ViewModel) {
        
        navigateToShowCalled += 1
    }
}

private class RouterSpy: OpenFileRouterProtocol{
    
    var navigateToFileCalled: Int = 0
    
    func navigateToFile(_ file: FileModels.FileItem) {
        
        navigateToFileCalled += 1
    }
}
