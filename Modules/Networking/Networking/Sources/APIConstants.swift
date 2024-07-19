//
//  APIConstants.swift
//  Networking
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import Foundation

public class APIConstants {
    private static var _instance: APIConstants?
    private static let lock = NSLock()
    
    private static var _dictionary: [String: Any]?
    
    private init(){}
    
    public static var instance: APIConstants {
        if _instance == nil {
            lock.lock()
            defer {
                lock.unlock()
            }
            if _instance == nil {
                _instance = APIConstants()
            }
        }
        return _instance!
    }
    
    private static var dictionary: [String: Any] {
        if _dictionary == nil {
            lock.lock()
            defer {
                lock.unlock()
            }
            if _dictionary == nil {
                _dictionary = Bundle.main.infoDictionary!
            }
        }
        return _dictionary!
    }
}

public extension APIConstants {
    var apiBaseUrl: String {
        return APIConstants.dictionary["API_BASE_URL"] as! String
    }
    
    var imageBaseUrl: String {
        return APIConstants.dictionary["IMAGE_BASE_URL"] as! String
    }
}
