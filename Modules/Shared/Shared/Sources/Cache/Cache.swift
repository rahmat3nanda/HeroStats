//
//  Cache.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 20/07/24.
//

import Foundation


/**
 This is a class for managing cache
 */
public class Cache {
    
    private init(){}
    
    
    /**
     Get a Caching instance with common level. Used to store Cache for regular data.
     - returns: Caching
     
     # Notes: #
     1. This instance is an instance of UserDefaultsCache.
     
     # Example #
     ```
     // Cache.common
     ```
     */
    public class var common: Caching {
        get {
            return UserDefaultsCache.instance
        }
    }
    
    /**
     Get a Caching instance with credentials level. Used to store Cache for credentials data.
     - returns: Caching
     
     # Notes: #
     1. This instance is an instance of KeychainCache.
     
     # Example #
     ```
     // Cache.credentials
     ```
     */
    public class var credentials: Caching {
        get {
            return KeychainCache.instance
        }
    }
    
    /**
     Method to delete all data for common and credential levels stored via Cache/Caching.
     # Example #
     ```
     // Cache.clear()
     ```
     */
    public class func clear() {
        common.clear()
        credentials.clear()
    }
}

// MARK: - Key
public extension Cache {
    class Key {
        public var rawValue: String
        
        
        public init(_ rawValue: String) {
            self.rawValue = rawValue
        }
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}
