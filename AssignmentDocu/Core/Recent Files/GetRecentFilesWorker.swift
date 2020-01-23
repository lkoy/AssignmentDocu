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

typealias GetRecentFilesWorkerAlias = BaseWorker<Void, Result<[String], GetRecentFilesWorkerError>>

final class GetRecentFilesWorker: GetRecentFilesWorkerAlias {
    
    override func job(completion: @escaping ((Result<[String], GetRecentFilesWorkerError>) -> Void)) {

        completion(.success([""]))
    }
}
