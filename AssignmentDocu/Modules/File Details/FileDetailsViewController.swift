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
 
}
