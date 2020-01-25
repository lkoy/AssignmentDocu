//
//  FileDetailsWorker.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

enum ReadFileWorkerError: Error {
    case readFileError
}

typealias ReadFileWorkerAlias = BaseWorker<String, Result<String, ReadFileWorkerError>>

final class ReadFileWorker: ReadFileWorkerAlias {
    
    override func job(input: String, completion: @escaping ((Result<String, ReadFileWorkerError>) -> Void)) {
        
        DispatchQueue(label: "com.ttg.AssignmentDocu.readFile", qos: .background).async{
            
            do {
                let contents = try String(contentsOfFile: input, encoding: .utf8)
                completion(.success(contents))
            } catch {
                print("File Read Error for file \(input)")
                completion(.failure(.readFileError))
            }
        }
    }
}
