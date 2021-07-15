//
//  EntryDetailViewController.swift
//  RedditLite
//
//  Created by Alana Santos on 14/07/21.
//

import UIKit

class EntryDetailViewController: BaseViewController, EntryDetailDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var entryImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var commentsIcon: UIImageView!
    
    @IBOutlet weak var emptyView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Properties
    
    var viewModel: EntryDetailViewModel? = nil
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    // MARK: - Setup views
    
    func bindViewModel() {
        if let viewModel = self.viewModel {
            self.authorLabel.text = viewModel.entry.author
            
            self.createDateLabel.text = viewModel.formattedTimeElapsed

            self.titleLabel.text = viewModel.entry.title
            self.commentsLabel.text = viewModel.formattedNumComments
            let imageUrl = viewModel.fullImageUrl ?? viewModel.entry.thumbnail ?? ""
            self.entryImageView.load(urlString: imageUrl, placeholder: UIImage(named: "icImagePlaceholder"))
            
            let iconCommentImage = self.commentsIcon?.image?.withRenderingMode(.alwaysTemplate)
            self.commentsIcon.tintColor = UIColor.systemPink
            self.commentsIcon.image = iconCommentImage
            
            self.emptyView.isHidden = true
            self.stackView.isHidden = false
        } else {
            self.emptyView.isHidden = false
            self.stackView.isHidden = true
        }
    }
    
    // MARK: - EntryDetailDelegate
    
    // Called when select item on master view controller
    func onSelect(entry: Entry?) {
        if let entry = entry {
            self.viewModel = EntryDetailViewModel(entry: entry)
            self.viewModel?.readEntry()
        } else {
            self.viewModel = nil
        }
        self.bindViewModel()
    }
    
    // Called when a item is dismissed from master view controller
    // If is the current open entry, reset the detail to its initial state
    func onRemove(entry: Entry) {
        if viewModel?.entry.id == entry.id {
            self.viewModel = nil
            self.bindViewModel()
        }
    }
        
}

// Protocol to create communication bewteen Master and Detail View Controller (SplitViewController)
protocol EntryDetailDelegate {
    func onSelect(entry: Entry?)
    func onRemove(entry: Entry)
}
