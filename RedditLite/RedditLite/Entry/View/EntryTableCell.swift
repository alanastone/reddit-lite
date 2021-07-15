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
    var delegate: ExpandImageDelegate? = nil
    
    // MARK: - Outlets
    
    @IBOutlet weak var entryImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var commentsIcon: UIImageView!
    
    // MARK: - Lifecycles
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.entryImageView.gestureRecognizers?.removeAll()
    }
    
    // MARK: - Bind
    
    func bind(with entry: Entry) {
        self.entry = entry
        self.authorLabel.text = entry.author
        
        if let createDateMs = entry.created {
            let createDate = Date(timeIntervalSince1970: createDateMs)
            let formatter = RelativeDateTimeFormatter()
            let relativeDate = formatter.localizedString(for: createDate, relativeTo: Date())
            formatter.unitsStyle = .full
            self.createDateLabel.text = relativeDate
            
        } else {
            self.createDateLabel.text = nil
        }

        self.titleLabel.text = entry.title
        self.commentsLabel.text = "\(entry.numComments ?? 0)"
        self.entryImageView.load(urlString: entry.thumbnail ?? "", placeholder: UIImage(named: "icImagePlaceholder"))
        
        if let _ = entry.fullImage {
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
    
}

protocol ExpandImageDelegate {
    func expandImage(for entry: Entry)
}
