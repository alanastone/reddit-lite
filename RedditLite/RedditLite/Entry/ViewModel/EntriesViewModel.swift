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
            
            // Don_t show dismissed entries
            let filteredEntries = response?.childrenEntries?.filter { !EntryStorage.isDismissed(entry: $0) } ?? []
            self.entries.insert(contentsOf: filteredEntries, at: 0)
            
            DispatchQueue.main.async {
                done?()
            }
        }, error: nil))
    }
    
    func remove(entry: Entry) {
        EntryStorage.dismiss(entry: entry)
        self.entries.removeAll(where: { $0.id == entry.id })
    }
    
    func restoreItems(_ done: (()->Void)? = nil) {
        EntryStorage.restoreDismissed()
        self.load(done)
    }
}
