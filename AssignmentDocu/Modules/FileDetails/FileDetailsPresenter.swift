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

}

final class FileDetailsPresenter<T: FileDetailsViewControllerProtocol, U: FileDetailsRouterProtocol>: BasePresenter<T, U> {

    let file: FileModels.FileItem
    
    init(viewController: T, router: U, file: FileModels.FileItem) {
        
        self.file = file
        super.init(viewController: viewController, router: router)
    }
    
}

extension FileDetailsPresenter: FileDetailsPresenterProtocol {

}
