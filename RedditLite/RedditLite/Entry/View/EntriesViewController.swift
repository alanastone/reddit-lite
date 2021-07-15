//
//  EntriesViewController.swift
//  RedditLite
//
//  Created by Alana Santos on 13/07/21.
//

import UIKit

class EntriesViewController: BaseViewController, UITableViewDataSource, ExpandImageDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private var viewModel = EntriesViewModel()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl.tintColor = UIColor.systemYellow
        self.refreshControl.addTarget(self, action: #selector(refreshList(_:)), for: .valueChanged)
        
        self.tableView.dataSource = self
        self.tableView.addSubview(self.refreshControl)
        
        self.viewModel.load { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EntryTableCell.identifier) as! EntryTableCell
        let entry = self.viewModel.entries[indexPath.row]
        cell.bind(with: entry)
        cell.delegate = self
        return cell
    }
    
    // MARK: - ExpandImageDelegate
    
    func expandImage(for entry: Entry) {
        EntryImageViewController.present(entry: entry, in: self)
    }
    
    // MARK: - Actions
    
    @objc private func refreshList(_ sender: Any) {
        self.viewModel.load { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
    }
}

