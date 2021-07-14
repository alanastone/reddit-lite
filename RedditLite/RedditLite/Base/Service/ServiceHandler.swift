//
//  ServiceHandler.swift
//  RedditLite
//
//  Created by Alana Santos on 13/07/21.
//

import Foundation

class ServiceHandler<T> {
    
    var success: ((T?)->Void)? = nil
    var error: ((Error?)->Void)? = nil
    
    init(success: ((T?)->Void)? = nil, error: ((Error?)->Void)? = nil) {
        self.success = success
        self.error = error
    }
    
}
