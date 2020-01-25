//
//  OpenFileViewController.swift
//  AssignmentDocu
//
//  Created by Gustavo Iglesias on 23/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import UIKit

final class OpenFileViewController: BaseViewController {

    var presenter: OpenFilePresenterProtocol!

    // MARK: - Component Declaration

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private var filesTableView: UITableView!
    
    private var viewModel = OpenFile.ViewModel(isLoading: true, files: [])
    
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
        title = "Files"
        
        filesTableView = UITableView(frame: CGRect.zero, style: .plain)
        filesTableView.translatesAutoresizingMaskIntoConstraints = false
        filesTableView.register(ImageOneLineTableViewCell.self, forCellReuseIdentifier: ImageOneLineTableViewCell.cellIdentifier)
        filesTableView.register(OneLineSchimmerTableViewCell.self, forCellReuseIdentifier: OneLineSchimmerTableViewCell.cellIdentifier)
        filesTableView.estimatedRowHeight = 50
        filesTableView.rowHeight = UITableView.automaticDimension
        filesTableView.separatorStyle = .none
        filesTableView.dataSource = self
        filesTableView.delegate = self
        view.addSubview(filesTableView)
    }

    override func setupConstraints() {

        NSLayoutConstraint.activate([
            
            filesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            filesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func setupAccessibilityIdentifiers() {
        
    }

    // MARK: - Actions

    // MARK: Private Methods

}

// MARK: - OpenFileViewControllerProtocol
extension OpenFileViewController: OpenFileViewControllerProtocol {
    
    func show(_ viewModel: OpenFile.ViewModel) {
        
        self.viewModel = viewModel
        self.filesTableView.reloadData()
    }
}

// MARK: - TableView Delegate and Data Source
extension OpenFileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.isLoading {
            return 1
        } else {
            return self.viewModel.files.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel.isLoading {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OneLineSchimmerTableViewCell.cellIdentifier, for: indexPath) as? OneLineSchimmerTableViewCell else {
                fatalError("Remember to register cellIdentifier")
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageOneLineTableViewCell.cellIdentifier, for: indexPath) as? ImageOneLineTableViewCell else {
                fatalError("Remember to register cellIdentifier")
            }
            let file = viewModel.files[indexPath.row]
            cell.leftImage = file.image
            cell.title = file.path
            return cell
        }
    }
}

extension OpenFileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if !self.viewModel.isLoading {
            self.presenter.selectFile(at: indexPath.row)
        }
    }
}
