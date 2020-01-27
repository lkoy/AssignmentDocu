//
//  GetRecentFilesInteractor.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 23/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

protocol GetRecentFilesInteractorProtocol: BaseInteractorProtocol {

    func getRecentFiles()
}

protocol GetRecentFilesInteractorCallbackProtocol: BaseInteractorCallbackProtocol {

    func filesFound(files: [FileModels.FileItem])
}

class GetRecentFilesInteractor: BaseInteractor {

    weak var presenter: GetRecentFilesInteractorCallbackProtocol!
    private let worker: GetRecentFilesWorkerAlias

    init(withGetRecentFilesWorker worker: GetRecentFilesWorkerAlias = GetRecentFilesWorker()) {
        self.worker = worker
        super.init()
    }
}

extension GetRecentFilesInteractor: GetRecentFilesInteractorProtocol {

    func getRecentFiles() {
        
        self.worker.execute() { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case.success(let recentFilesList):
                self.presenter.filesFound(files: recentFilesList)
            case .failure:
                self.presenter.filesFound(files: [])
            }
        }
    }
}
