//
//  EntryDetailViewModel.swift
//  RedditLite
//
//  Created by Alana Santos on 13/07/21.
//

import Foundation

class EntryDetailViewModel {
    
    var entry: Entry
    
    var formattedTimeElapsed: String? {
        get {
            if let createDateMs = entry.created {
                let createDate = Date(timeIntervalSince1970: createDateMs)
                let formatter = RelativeDateTimeFormatter()
                let relativeDate = formatter.localizedString(for: createDate, relativeTo: Date())
                formatter.unitsStyle = .full
                return relativeDate
                
            } else {
                return nil
            }
        }
    }
    
    var formattedNumComments: String {
        get {
            return "\(self.entry.numComments ?? 0)"
        }
    }
    
    var fullImageUrl: String? {
        get {
            guard let fullImage = self.entry.fullImage else {
                return nil
            }
            
            if (fullImage.contains(".jpg") || fullImage.contains(".png") || fullImage.contains(".jpeg")) {
                return fullImage
            }
            
            return nil
        }
    }
    
    var isReaded: Bool {
        get {
            EntryStorage.isReaded(entry: self.entry)
        }
    }
    
    
    init(entry: Entry) {
        self.entry = entry
    }
    
    func readEntry() {
        EntryStorage.read(entry: self.entry)
    }
}
