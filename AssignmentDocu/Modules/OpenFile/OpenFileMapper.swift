//
//  OpenFileMapper.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation
import UIKit.UIImage

final class OpenFileMapper {

    final func map(files: [FileModels.FileItem]) -> OpenFile.ViewModel {
        
        var filesView: [OpenFile.ViewModel.CsvFile] = []
        for file in files {
            
            let image = UIImage(named: file.kind.image)
            let fileView = OpenFile.ViewModel.CsvFile(name: file.name, image: image)
            filesView.append(fileView)
        }
        return OpenFile.ViewModel(isLoading: false, files: filesView)
    }
}
