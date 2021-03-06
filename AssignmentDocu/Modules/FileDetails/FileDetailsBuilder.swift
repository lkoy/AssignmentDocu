//
//  FileDetailsBuilder.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation
import UIKit.UIViewController

final class FileDetailsBuilder: BaseBuilder {

    static func build(withFile file: FileModels.FileItem) -> UIViewController {

        let viewController: FileDetailsViewController = FileDetailsViewController()
        let router: FileDetailsRouter = FileDetailsRouter(viewController: viewController)
        let getFileDetailsInteractor = FileDetailsInteractor()
        let fileDetailsMapper = FileDetailsMapper()
        
        let presenter: FileDetailsPresenter = FileDetailsPresenter(viewController: viewController,
                                                                   router: router,
                                                                   file: file,
                                                                   getFileDetailsInteractor: getFileDetailsInteractor,
                                                                   fileDetailsMapper: fileDetailsMapper)
        viewController.presenter = presenter
        getFileDetailsInteractor.presenter = presenter

        return viewController
    }

}
