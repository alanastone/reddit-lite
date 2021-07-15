//
//  EntriesViewController.swift
//  RedditLite
//
//  Created by Alana Santos on 13/07/21.
//

import UIKit

class EntriesViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, EntryCellDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    private var viewModel = EntriesViewModel()
    private let refreshControl = UIRefreshControl()
    var detailDelegate: EntryDetailDelegate? = nil
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showLoading()
        
        // Customization of Pull to Refresh
        self.refreshControl.tintColor = UIColor.systemYellow
        self.refreshControl.addTarget(self, action: #selector(refreshList(_:)), for: .valueChanged)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.addSubview(self.refreshControl)
        
        // Fetch items from view model
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
        // Communicates to DetailViewController to show the information from selected entry
        self.detailDelegate?.onSelect(entry: entry)
        // In order to work on iPhone devices the showDetail must be called manually
        if let viewController = self.detailDelegate as? UIViewController {
            self.splitViewController?.showDetailViewController(viewController, sender: self)
        }
        // Reload item to update status read/unread
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        // Keep the row selected after reload
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
    }

    // MARK: - EntryCellDelegate
    
    func expandImage(for entry: Entry) {
        EntryImageViewController.present(entry: entry, in: self)
    }
    
    func dismiss(entry: Entry) {
        if let index = self.viewModel.entries.firstIndex(where: { $0.id == entry.id}) {
            // Setup detail view controller if needed
            self.detailDelegate?.onRemove(entry: entry)
            // Remove from view model's list
            self.viewModel.remove(entry: entry)
            // Updates table with animation
            self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
            self.tableView.endUpdates()
        }
    }
    
    // MARK: - Actions
    
    @objc private func refreshList(_ sender: Any) {
        self.viewModel.load { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
    }
    
    @IBAction func restoreItems(_ sender: Any) {
        self.viewModel.restoreItems { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

