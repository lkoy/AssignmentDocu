//
//  ParseCsvFileWorker.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

enum ParseCsvFileWorkerError: Error {
    case parsingFileError
}

typealias ParseCsvFileWorkerAlias = BaseWorker<String, Result<DetailModels.DetailFile, ParseCsvFileWorkerError>>

final class ParseCsvFileWorker: ParseCsvFileWorkerAlias {
    
    private let mapper: CsvFileMapper
    
    init(mapper: CsvFileMapper = CsvFileMapper()) {
        
        self.mapper = mapper
        super.init()
    }
    
    override func job(input: String, completion: @escaping (Result<DetailModels.DetailFile, ParseCsvFileWorkerError>) -> Void) {
        
        let cleanInput = cleanRows(file: input)
        var csvRows: [[String]] = []
        let rows = cleanInput.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            csvRows.append(columns)
        }
        
        completion(.success(mapper.map(csvFileItems: csvRows)))
    }
    
    private func cleanRows(file:String)->String{
        var cleanFile = file
        
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\"", with: "")
        return cleanFile
    }
}
