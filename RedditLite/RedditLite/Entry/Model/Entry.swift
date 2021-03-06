//
//  Entry.swift
//  RedditLite
//
//  Created by Alana Santos on 12/07/21.
//

import Foundation

struct Entry: Decodable {
    let id: String?
    let title: String?
    let author: String?
    let thumbnail: String?
    let fullImage: String?
    let created: Double?
    let numComments: Int?
    
    private enum CodingKeys : String, CodingKey {
        case title, author, thumbnail, created, numComments = "num_comments", fullImage = "url_overridden_by_dest", id = "name"
    }
}
