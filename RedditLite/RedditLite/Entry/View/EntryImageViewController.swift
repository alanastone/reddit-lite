//
//  EntryImageViewController.swift
//  RedditLite
//
//  Created by Alana Santos on 14/07/21.
//

import UIKit

class EntryImageViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    // MARK: - Properties
    
    var viewModel: EntryDetailViewModel? = nil
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shareButton.isEnabled = false
        if let urlString = self.viewModel?.fullImageUrl {
            self.imageView.load(urlString: urlString, placeholder: UIImage(named: "imgPlaceholder"), success: { _ in
                self.shareButton.isEnabled = true
            })
        }
    }
    
    // MARK: - Actions
    
    @IBAction func performShare(_ sender: Any) {
        if let image = self.imageView.image {
            let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            controller.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
            self.present(controller, animated: true)
        }
    }
    
    // MARK: - Create view controller
    
    static func present(entry: Entry, in parentViewController: UIViewController) {
        let storyboard = UIStoryboard(name: "Entry", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "EntryImageNavigationController") as UINavigationController
        let viewModel = EntryDetailViewModel(entry: entry)
        (controller.viewControllers.first as? EntryImageViewController)?.viewModel = viewModel
        parentViewController.present(controller, animated: true, completion: nil)

    }
    
}
