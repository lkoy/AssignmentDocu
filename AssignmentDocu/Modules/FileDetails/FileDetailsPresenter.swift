//
//  FileDetailsPresenter.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation
import UIKit.UIAlertController

protocol FileDetailsViewControllerProtocol: BaseViewControllerProtocol {

    func show(_ viewModel: FileDetails.ViewModel)
    func setTitle(_ title: String)
    func showEmptyState()
    func showErrorAlert(message: String, handler: @escaping ((UIAlertAction) -> Void))
}

protocol FileDetailsPresenterProtocol: BasePresenterProtocol {

    func prepareView()
}

final class FileDetailsPresenter<T: FileDetailsViewControllerProtocol, U: FileDetailsRouterProtocol>: BasePresenter<T, U> {

    let file: FileModels.FileItem
    
    private let getFileDetailsInteractor: FileDetailsInteractorProtocol
    private let fileDetailsMapper: FileDetailsMapper
    
    init(viewController: T, router: U, file: FileModels.FileItem, getFileDetailsInteractor: FileDetailsInteractorProtocol, fileDetailsMapper: FileDetailsMapper) {
        
        self.file = file
        self.getFileDetailsInteractor = getFileDetailsInteractor
        self.fileDetailsMapper = fileDetailsMapper
        super.init(viewController: viewController, router: router)
    }
    
}

extension FileDetailsPresenter: FileDetailsPresenterProtocol {

    func prepareView() {
        
        self.viewController.setTitle(self.file.name)
        self.getFileDetailsInteractor.getFileDetailsFromPath(self.file.path, fileType: self.file.kind)
    }
}

extension FileDetailsPresenter: FileDetailsInteractorCallbackProtocol {
    
    func parsedFile(_ parsed: DetailModels.DetailFile) {
        
        if parsed.items.isEmpty {
            self.viewController.showEmptyState()
        } else {
            self.viewController.show(self.fileDetailsMapper.map(detailFile: parsed))
        }
    }
    
    func showError(error: FileDetailsInteractorError) {
        
        var message = "Something went wrong!"
        
        switch error {
        case .readFileError:
            message = "Reading file error"
        case .parsingFileError:
            message = "File format incorrect"
        }
        
        self.viewController.showErrorAlert(message: message, handler: { action in
            
            self.viewController.showEmptyState()
        })
    }
}
