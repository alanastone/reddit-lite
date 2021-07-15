//
//  EntryResponse.swift
//  RedditLite
//
//  Created by Alana Santos on 13/07/21.
//

import Foundation

struct EntryResponse: Decodable {
    let data: EntryResponseData?
}

struct EntryResponseData: Decodable {
    let after: String?
    let before: String?
    let children: [EntryData]?
    var childrenEntries: [Entry]? {
        get {
            return children?.compactMap { return $0.data }
        }
    }
}

struct EntryData: Decodable {
    let data: Entry?
}
