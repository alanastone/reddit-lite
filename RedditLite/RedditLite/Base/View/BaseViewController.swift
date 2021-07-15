//
//  BaseViewController.swift
//  RedditLite
//
//  Created by Alana Santos on 14/07/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
    }
    
    // MARK: - Navigation Bar Setup
    
    func setupNavigationBar() {
        
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.shadowImage = nil
            navigationBar.isTranslucent = false
            navigationBar.isOpaque = true
            navigationBar.barTintColor = UIColor.systemBackground
            navigationBar.tintColor = UIColor.systemPurple
            navigationBar.barStyle = .black
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPink]
        }
        
        self.navigationItem.title = self.title
        let _ = self.navigationItem.rightBarButtonItems?.map { $0.tintColor = UIColor.systemPink }
        let _ = self.navigationItem.leftBarButtonItems?.map { $0.tintColor = UIColor.systemPink }
    }
    
    // MARK: - Actions
    
    @IBAction func performDismiss(_ sender: Any) {
        if let navigation = self.navigationController, navigation.viewControllers.count > 1 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
