//
//  FileMapper.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

class FileMapper {
    
    final func map(fileItems: [String]) -> [FileModels.FileItem] {
        guard !fileItems.isEmpty else {
            return []
        }
        
        var files: [FileModels.FileItem] = []
        fileItems.forEach { (file) in
            guard let mapped = map(fileItem: file) else {
                return
            }
            files.append(mapped)
        }
        return files
    }
    
    final func map(fileItem: String) -> FileModels.FileItem? {

        guard fileItem.count > 0 else {
            return nil
        }
        return FileModels.FileItem(path: fileItem, kind: .csv)
    }
}
