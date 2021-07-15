//
//  EntryService.swift
//  RedditLite
//
//  Created by Alana Santos on 13/07/21.
//

import Foundation

class EntryStorage {
    
    static private let readedEntriesKey = "com.stones.RedditLite.readedEntries"
    static private let dismissedEntriesKey = "com.stones.RedditLite.dismissedEntriesKey"
    
    static private var readedEntries: [String]? {
        get {
            let defaults = UserDefaults.standard
            if let readedString = defaults.string(forKey: readedEntriesKey ){
                return readedString.split(separator: ",").map{ String($0) }
            }
            return nil
        }
        set {
            let defaults = UserDefaults.standard
            if let readedList = newValue {
                defaults.set(readedList.joined(separator:","), forKey: readedEntriesKey)
                defaults.synchronize()
            } else {
                defaults.removeObject(forKey: readedEntriesKey)
            }
        }
    }
    
    static private var dismissedEntries: [String]? {
        get {
            let defaults = UserDefaults.standard
            if let readedString = defaults.string(forKey: dismissedEntriesKey ){
                return readedString.split(separator: ",").map{ String($0) }
            }
            return nil
        }
        set {
            let defaults = UserDefaults.standard
            if let readedList = newValue {
                defaults.set(readedList.joined(separator:","), forKey: dismissedEntriesKey)
                defaults.synchronize()
            } else {
                defaults.removeObject(forKey: dismissedEntriesKey)
            }
        }
    }
    
    static func read(entry: Entry) {
        if let id = entry.id {
            if !(isReaded(entry: entry)) {
                self.readedEntries = (readedEntries ?? []) + [id]
            }
        }
    }
    
    static func isReaded(entry: Entry?) -> Bool {
        if let id = entry?.id {
            return readedEntries?.contains(id) == true
        }
        return false
    }
    
    static func dismiss(entry: Entry) {
        if let id = entry.id {
            self.dismissedEntries = (dismissedEntries ?? []) + [id]
        }
    }
    
    static func restoreDismissed() {
        self.dismissedEntries = nil
    }
    
    static func isDismissed(entry: Entry?) -> Bool {
        if let id = entry?.id {
            return dismissedEntries?.contains(id) == true
        }
        return false
    }
    
}
