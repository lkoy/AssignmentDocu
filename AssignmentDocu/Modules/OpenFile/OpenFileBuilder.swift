//
//  OpenFileBuilder.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 23/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation
import UIKit.UIViewController

final class OpenFileBuilder: BaseBuilder {

    static func build(withFiles files: [FileModels.FileItem]) -> UIViewController {

        let viewController: OpenFileViewController = OpenFileViewController()
        let router: OpenFileRouter = OpenFileRouter(viewController: viewController)
        let openFileMapper = OpenFileMapper()
        
        let presenter: OpenFilePresenter = OpenFilePresenter(viewController: viewController, router: router, fileItems: files, fileMapper: openFileMapper)
        viewController.presenter = presenter

        return viewController
    }

}
