//
//  SplashPresenter.swift
//  AssignmentMoneyou
//
//  Created by ttg on 22/09/2019.
//  Copyright © 2019 ttg. All rights reserved.
//

import Foundation

protocol SplashViewControllerProtocol: BaseViewControllerProtocol {

}

protocol SplashPresenterProtocol: BasePresenterProtocol {
    func getInitDetails()
}

final class SplashPresenter<T: SplashViewControllerProtocol, U: SplashRouterProtocol>: BasePresenter<T, U> {
    
    private let getRecentFilesInteractor: GetRecentFilesInteractorProtocol

    init(viewController: T, router: U, getRecentFilesInteractor: GetRecentFilesInteractorProtocol) {

        self.getRecentFilesInteractor = getRecentFilesInteractor
        super.init(viewController: viewController, router: router)
    }
    
    func getRecentFiles() {
        
        getRecentFilesInteractor.getRecentFiles()
    }
}

extension SplashPresenter: SplashPresenterProtocol {

    func getInitDetails() {
        
        getRecentFiles()
    }
}

extension SplashPresenter: GetRecentFilesInteractorCallbackProtocol {

    func filesFound(files: [FileModels.FileItem]) {
        
        self.router.navigateToOpenFiles(withFiles: files)
    }
    
    func showError() {
        
    }
}
