//
//  EntryDetailViewController.swift
//  RedditLite
//
//  Created by Alana Santos on 14/07/21.
//

import UIKit

class EntryDetailViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var entryImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var commentsIcon: UIImageView!
    
    // MARK: - Properties
    
    var viewModel: EntryDetailViewModel? = nil
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authorLabel.text = viewModel?.entry.author
        
        self.createDateLabel.text = self.viewModel?.formattedTimeElapsed

        self.titleLabel.text = self.viewModel?.entry.title
        self.commentsLabel.text = self.viewModel?.formattedNumComments
        let imageUrl = self.viewModel?.fullImageUrl ?? self.viewModel?.entry.thumbnail ?? ""
        self.entryImageView.load(urlString: imageUrl, placeholder: UIImage(named: "icImagePlaceholder"))
        
        let iconCommentImage = self.commentsIcon?.image?.withRenderingMode(.alwaysTemplate)
        self.commentsIcon.tintColor = UIColor.systemPink
        self.commentsIcon.image = iconCommentImage
        
    }
        
}
