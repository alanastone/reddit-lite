//
//  EntriesViewModel.swift
//  RedditLite
//
//  Created by Alana Santos on 13/07/21.
//

import Foundation

class EntriesViewModel {
    
    var after: String?
    var entries: [Entry] = []
    
    init() { }
    
    func load(_ done: (()->Void)? = nil) {
        EntryService().getEntries(self.after, handler: ServiceHandler(success: {
            response in
            self.after = response?.after
            self.entries.insert(contentsOf: response?.childrenEntries ?? [], at: 0)
            DispatchQueue.main.async {
                done?()
            }
        }, error: nil))
    }
}
