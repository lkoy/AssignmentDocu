//
//  FileDetailsViewController.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import UIKit

final class FileDetailsViewController: BaseViewController {

    var presenter: FileDetailsPresenterProtocol!

    // MARK: - Component Declaration

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private var viewModel = FileDetails.ViewModel(screenTitle: "", firstNameTitle: "", surNameTitle: "", issueCountTitle: "", dateTitle: "", issues: [])
    
    public enum AccessibilityIds {
        
    }

    // MARK: - ViewLife Cycle
    /*
     Order:
     - viewDidLoad
     - viewWillAppear
     - viewDidAppear
     - viewWillDisapear
     - viewDidDisappear
     - viewWillLayoutSubviews
     - viewDidLayoutSubviews
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.prepareView()
    }

    // MARK: - Setup

    override func setupComponents() {

        view.backgroundColor = .appWhite
    }

    override func setupConstraints() {

    }
    
    override func setupAccessibilityIdentifiers() {
        
    }

    // MARK: - Actions

    // MARK: Private Methods

}

// MARK: - FileDetailsViewControllerProtocol
extension FileDetailsViewController: FileDetailsViewControllerProtocol {
 
    func show(_ viewModel: FileDetails.ViewModel) {
        
        self.viewModel = viewModel
//        self.filesTableView.reloadData()
    }
}
