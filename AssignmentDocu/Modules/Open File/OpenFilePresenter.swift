//
//  OpenFilePresenter.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 23/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation

protocol OpenFileViewControllerProtocol: BaseViewControllerProtocol {

}

protocol OpenFilePresenterProtocol: BasePresenterProtocol {

}

final class OpenFilePresenter<T: OpenFileViewControllerProtocol, U: OpenFileRouterProtocol>: BasePresenter<T, U> {

    override init(viewController: T, router: U) {
        super.init(viewController: viewController, router: router)
    }
    
}

extension OpenFilePresenter: OpenFilePresenterProtocol {

}
