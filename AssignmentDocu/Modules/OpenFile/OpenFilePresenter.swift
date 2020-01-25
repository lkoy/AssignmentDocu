//
//  OpenFilePresenter.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 23/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

protocol OpenFileViewControllerProtocol: BaseViewControllerProtocol {

    func show(_ viewModel: OpenFile.ViewModel)
}

protocol OpenFilePresenterProtocol: BasePresenterProtocol {

    func prepareView()
    func selectFile(at: Int)
}

final class OpenFilePresenter<T: OpenFileViewControllerProtocol, U: OpenFileRouterProtocol>: BasePresenter<T, U> {

    private let openFileMapper: OpenFileMapper
    
    let files: [FileModels.FileItem]
    
    init(viewController: T, router: U, fileItems: [FileModels.FileItem], fileMapper: OpenFileMapper) {
        
        self.files = fileItems
        self.openFileMapper = fileMapper
        super.init(viewController: viewController, router: router)
    }
    
}

extension OpenFilePresenter: OpenFilePresenterProtocol {

    func prepareView() {
        
        self.viewController.show(self.openFileMapper.map(files: self.files))
    }
    
    func selectFile(at: Int) {
        
        self.router.navigateToFile(self.files[at])
    }
}
