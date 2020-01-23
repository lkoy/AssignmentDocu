//
//  SplashRouter.swift
//  AssignmentMoneyou
//
//  Created by ttg on 22/09/2019.
//  Copyright © 2019 ttg. All rights reserved.
//

import Foundation

protocol SplashRouterProtocol: BaseRouterProtocol {
    func navigateToOpenFiles()
}

class SplashRouter: BaseRouter, SplashRouterProtocol {

    func navigateToOpenFiles() {
        navigationController?.navigationBar.applyStyle()
        navigationController?.setViewControllers([OpenFileBuilder.build()], animated: true)
    }
}
