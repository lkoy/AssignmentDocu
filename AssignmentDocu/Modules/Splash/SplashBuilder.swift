//
//  SplashBuilder.swift
//  AssignmentMoneyou
//
//  Created by ttg on 22/09/2019.
//  Copyright © 2019 ttg. All rights reserved.
//

import Foundation
import UIKit.UIViewController

final class SplashBuilder: BaseBuilder {

    static func build() -> UIViewController {

        let viewController: SplashViewController = SplashViewController()
        let router: SplashRouter = SplashRouter(viewController: viewController)
        let getRecentFiles = GetRecentFilesInteractor()

        let presenter: SplashPresenter = SplashPresenter(viewController: viewController, router: router, getRecentFilesInteractor: getRecentFiles)
        
        viewController.presenter = presenter
        getRecentFiles.presenter = presenter

        return viewController
    }
}
