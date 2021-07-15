//
//  EntriesViewController.swift
//  RedditLite
//
//  Created by Alana Santos on 13/07/21.
//

import UIKit

class EntriesViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, ExpandImageDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    private var viewModel = EntriesViewModel()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showLoading()
        
        self.refreshControl.tintColor = UIColor.systemYellow
        self.refreshControl.addTarget(self, action: #selector(refreshList(_:)), for: .valueChanged)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.addSubview(self.refreshControl)
        
        self.viewModel.load { [weak self] in
            self?.hideLoading()
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Setup views
    
    func showLoading() {
        self.loadingIndicator.isHidden = false
        self.loadingIndicator.startAnimating()
        self.tableView.isHidden = true
    }
    
    func hideLoading() {
        self.loadingIndicator.isHidden = true
        self.tableView.isHidden = false
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EntryTableCell.identifier) as! EntryTableCell
        let entry = self.viewModel.entries[indexPath.row]
        cell.bind(with: EntryDetailViewModel(entry: entry))
        cell.delegate = self
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = self.viewModel.entries[indexPath.row]
        let detailViewModel = EntryDetailViewModel(entry: entry)
        self.performSegue(withIdentifier: "EntryDetailsSegue", sender: detailViewModel)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewModel = sender as? EntryDetailViewModel, let detailViewController = segue.destination as? EntryDetailViewController {
            detailViewController.viewModel = viewModel
        }
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

