//
//  EntryTableCell.swift
//  RedditLite
//
//  Created by Alana Santos on 14/07/21.
//

import UIKit

class EntryTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "EntryTableCell"
    var entry: Entry? = nil
    var delegate: EntryCellDelegate? = nil
    
    // MARK: - Outlets
    
    @IBOutlet weak var entryImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var commentsIcon: UIImageView!
    @IBOutlet weak var statusStackView: UIStackView!
    
    // MARK: - Lifecycles
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.entryImageView.gestureRecognizers?.removeAll()
    }
    
    // MARK: - Bind
    
    func bind(with entryViewModel: EntryDetailViewModel) {
        self.entry = entryViewModel.entry
        self.authorLabel.text = self.entry?.author
        
        self.statusStackView.subviews.first?.isHidden = entryViewModel.isReaded
        
        self.createDateLabel.text = entryViewModel.formattedTimeElapsed

        self.titleLabel.text = self.entry?.title
        self.commentsLabel.text = entryViewModel.formattedNumComments
        self.entryImageView.load(urlString: self.entry?.thumbnail ?? "", placeholder: UIImage(named: "icImagePlaceholder"))
        
        if let _ = entryViewModel.fullImageUrl {
            self.entryImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapThumbnail)))
        }
        
        let iconCommentImage = self.commentsIcon?.image?.withRenderingMode(.alwaysTemplate)
        self.commentsIcon.tintColor = UIColor.systemPink
        self.commentsIcon.image = iconCommentImage
    }
    
    @IBAction func didTapThumbnail(_ sender: UITapGestureRecognizer) {
        if let entry = self.entry {
            delegate?.expandImage(for: entry)
        }
    }
    
    @IBAction func dimissEntry(_ sender: UIButton) {
        if let entry = self.entry {
            delegate?.dismiss(entry: entry)
        }
    }
    
}

protocol EntryCellDelegate {
    func expandImage(for entry: Entry)
    func dismiss(entry: Entry)
}
