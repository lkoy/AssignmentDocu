//
//  GetRecentFilesWorker.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 23/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

enum GetRecentFilesWorkerError: Error {
    case getRecentFilesError
}

typealias GetRecentFilesWorkerAlias = BaseWorker<Void, Result<[FileModels.FileItem], GetRecentFilesWorkerError>>

final class GetRecentFilesWorker: GetRecentFilesWorkerAlias {
    
    private let mapper: FileMapper
    
    init(mapper: FileMapper = FileMapper()) {
        
        self.mapper = mapper
        super.init()
    }
    
    override func job(completion: @escaping ((Result<[FileModels.FileItem], GetRecentFilesWorkerError>) -> Void)) {

        let mainBundle = Bundle(for: type(of: self))
        let bundleURL = mainBundle.url(forResource: "Documents", withExtension: "bundle")
        guard let bURL = bundleURL, let filesBundle = Bundle(url: bURL) else { completion(.success([])); return }

        let files = filesBundle.paths(forResourcesOfType: "csv", inDirectory: ".")
        
        completion(.success(mapper.map(fileItems: files)))
    }
}
