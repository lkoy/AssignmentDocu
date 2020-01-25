//
//  FileDetailsInteractor.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

protocol FileDetailsInteractorProtocol: BaseInteractorProtocol {

    func getFileDetailsFromPath(_ path: String, fileType: FileModels.FileItem.Kind)
}

protocol FileDetailsInteractorCallbackProtocol: BaseInteractorCallbackProtocol {

    func parsedFile(_ parsed: DetailModels.DetailFile)
    func showError()
}

class FileDetailsInteractor: BaseInteractor {

    weak var presenter: FileDetailsInteractorCallbackProtocol!
    private let readFileworker: ReadFileWorkerAlias
    private let parseCsvFileworker: ParseCsvFileWorkerAlias

    init(withReadFileWorker readFileworker: ReadFileWorkerAlias = ReadFileWorker(), parseCsvFileWorker: ParseCsvFileWorkerAlias = ParseCsvFileWorker()) {
        
        self.readFileworker = readFileworker
        self.parseCsvFileworker = parseCsvFileWorker
        super.init()
    }
    
    func parseFile(data: String, fileType: FileModels.FileItem.Kind) {
        
        switch fileType {
        case .csv:
            self.parseCsvFileworker.execute(input: data) { [weak self] (result) in
                guard let self = self else { return }
                
                switch result {
                case .success(let parsedFile):
                    self.presenter.parsedFile(parsedFile)
                case .failure:
                    self.presenter.showError()
                }
            }
        }
    }
}

extension FileDetailsInteractor: FileDetailsInteractorProtocol {

    func getFileDetailsFromPath(_ path: String, fileType: FileModels.FileItem.Kind) {
        
        readFileworker.execute(input: path) { [weak self] (result) in
        guard let self = self else { return }
            
            switch result {
            case .success(let dataFile):
                self.parseFile(data: dataFile, fileType: fileType)
            case .failure:
                self.presenter.showError()
            }
        }
    }
}
