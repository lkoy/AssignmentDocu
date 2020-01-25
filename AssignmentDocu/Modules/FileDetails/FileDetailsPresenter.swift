//
//  FileDetailsPresenter.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

protocol FileDetailsViewControllerProtocol: BaseViewControllerProtocol {

}

protocol FileDetailsPresenterProtocol: BasePresenterProtocol {

    func prepareView()
}

final class FileDetailsPresenter<T: FileDetailsViewControllerProtocol, U: FileDetailsRouterProtocol>: BasePresenter<T, U> {

    let file: FileModels.FileItem
    
    private let getFileDetailsInteractor: FileDetailsInteractorProtocol
    
    init(viewController: T, router: U, file: FileModels.FileItem, getFileDetailsInteractor: FileDetailsInteractorProtocol) {
        
        self.file = file
        self.getFileDetailsInteractor = getFileDetailsInteractor
        super.init(viewController: viewController, router: router)
    }
    
}

extension FileDetailsPresenter: FileDetailsPresenterProtocol {

    func prepareView() {
        
        self.getFileDetailsInteractor.getFileDetailsFromPath(self.file.path, fileType: self.file.kind)
    }
}

extension FileDetailsPresenter: FileDetailsInteractorCallbackProtocol {
    
    func parsedFile(_ parsed: DetailModels.DetailFile) {
        
        print("details")
    }
}
