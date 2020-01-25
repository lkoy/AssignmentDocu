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
    
    private var emptyView: UIView!
    private var emptyMessageLabel: Label!
    
    private var itemsTableView: UITableView!
    
    private var viewModel = FileDetails.ViewModel(isLoading: true, issueCountTitle: "", dateTitle: "", issues: [])
    
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
        
        itemsTableView = UITableView(frame: CGRect.zero, style: .plain)
        itemsTableView.translatesAutoresizingMaskIntoConstraints = false
        itemsTableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.cellIdentifier)
        itemsTableView.register(ItemSchimmerTableViewCell.self, forCellReuseIdentifier: ItemSchimmerTableViewCell.cellIdentifier)
        itemsTableView.estimatedRowHeight = 80
        itemsTableView.rowHeight = UITableView.automaticDimension
        itemsTableView.separatorStyle = .singleLine
        itemsTableView.dataSource = self
        view.addSubview(itemsTableView)
        
        emptyView = UIView()
        emptyView.backgroundColor = .appWhite
        emptyView.isHidden = true
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyView)
        
        emptyMessageLabel = Label(style: .title1)
        emptyMessageLabel.text = "EMPTY FILE"
        emptyMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyView.addSubview(emptyMessageLabel)
    }

    override func setupConstraints() {

        NSLayoutConstraint.activate([
            
            itemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            itemsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyMessageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyMessageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor)
        ])
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
        itemsTableView.reloadData()
    }
    
    func setTitle(_ title: String) {
        
        self.title = title
    }
    
    func showEmptyState() {
        
        self.emptyView.isHidden = false
        viewModel = FileDetails.ViewModel(isLoading: false, issueCountTitle: "", dateTitle: "", issues: [])
        itemsTableView.reloadData()
    }
    
    func showErrorAlert() {
        
        let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
}

// MARK: - TableView Delegate and Data Source
extension FileDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.isLoading {
            return 1
        } else {
            return self.viewModel.issues.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel.isLoading {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemSchimmerTableViewCell.cellIdentifier, for: indexPath) as? ItemSchimmerTableViewCell else {
                fatalError("Remember to register cellIdentifier")
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.cellIdentifier, for: indexPath) as? ItemTableViewCell else {
                fatalError("Remember to register cellIdentifier")
            }
            let issue = viewModel.issues[indexPath.row]
            cell.title = issue.fullName
            cell.subtitle = issue.date
            cell.issues = viewModel.issueCountTitle + ": " + issue.issueCount
            return cell
        }
    }
}
