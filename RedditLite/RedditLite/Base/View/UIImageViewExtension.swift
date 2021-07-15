//
//  UIImageViewExtension.swift
//  RedditLite
//
//  Created by Alana Santos on 14/07/21.
//

import UIKit

extension UIImageView {
    func load(urlString: String, placeholder: UIImage? = nil, success: ((UIImage)->Void)? = nil, error: (()->Void)? = nil) {
        self.load(url: URL(string: urlString), placeholder: placeholder, success: success, error: error)
    }
    
    func load(url: URL?, placeholder: UIImage? = nil, success: ((UIImage)->Void)? = nil, error: (()->Void)? = nil) {
        self.image = placeholder
        if let url = url {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                            success?(image)
                        }
                    }
                } else {
                    error?()
                }
            }
        } else {
            error?()
        }
    }
}
