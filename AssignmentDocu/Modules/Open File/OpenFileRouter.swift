//
//  OpenFileRouter.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 23/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

protocol OpenFileRouterProtocol: BaseRouterProtocol {

    func navigateToFile(_ file: FileModels.FileItem)
}

class OpenFileRouter: BaseRouter, OpenFileRouterProtocol {

    func navigateToFile(_ file: FileModels.FileItem) {
        
        viewController.navigationController?.pushViewController(FileDetailsBuilder.build(withFile: file), animated: true)
    }
}
