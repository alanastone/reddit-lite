//
//  EntryService.swift
//  RedditLite
//
//  Created by Alana Santos on 13/07/21.
//

import Foundation

class EntryService: BaseService {
    
    func getEntries(_ after: String? = nil, handler: ServiceHandler<EntryResponseData>) {
        var serviceUrl = "/top/.json"
        
        if let after = after {
            serviceUrl += "?after=\(after)"
        }
        
        let serviceHandler = ServiceHandler<EntryResponse>(success: { response in
            handler.success?(response?.data)
        }, error: handler.error)
        
        self.get(serviceUrl, handler: serviceHandler)
    }
    
}
