//
//  FileItemBuilder.swift
//  AssignmentDocuTests
//
//  Created by Iglesias, Gustavo on 27/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation
@testable import AssignmentDocu

final class FileItemBuilder {

    private var name: String = "issues"
    private var path: String = "/document/issues"
    private var kind: FileModels.FileItem.Kind = .csv

    func with(name: String) -> FileItemBuilder {
        self.name = name
        return self
    }
    
    func with(path: String) -> FileItemBuilder {
        self.path = path
        return self
    }
    
    func with(kind: FileModels.FileItem.Kind) -> FileItemBuilder {
        self.kind = kind
        return self
    }
    
    func build() -> FileModels.FileItem {
        return FileModels.FileItem(name: name,
                                   path: path,
                                   kind: kind)
    }
    
}
