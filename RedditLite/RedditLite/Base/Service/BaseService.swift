//
//  BaseService.swift
//  RedditLite
//
//  Created by Alana Santos on 14/07/21.
//

import Foundation

class BaseService {
    
    internal func buildUrl(with url: String) -> URL? {
        return URL(string: ApiConfig.redditBaseApiUrl + url)
    }
    
    internal func get<T:Decodable>(_ urlString: String, params: [String:AnyObject]? = nil, handler: ServiceHandler<T>) {
        if let url = buildUrl(with: urlString) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, failure in
                if let failure = failure {
                    handler.error?(failure)
                } else if let data = data {
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        handler.success?(result)
                    } catch {
                        handler.error?(error)
                    }
                }
            }
            task.resume()
            
        } else {
            handler.error?(nil)
        }
    }
    
}
