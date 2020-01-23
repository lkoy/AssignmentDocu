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

    static func build() -> UIViewController {

        let viewController: OpenFileViewController = OpenFileViewController()
        let router: OpenFileRouter = OpenFileRouter(viewController: viewController)
        let presenter: OpenFilePresenter = OpenFilePresenter(viewController: viewController, router: router)
        viewController.presenter = presenter

        return viewController
    }

}
