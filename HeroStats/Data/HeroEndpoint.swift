//
//  HeroEndpoint.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import Foundation

enum HeroEndpoint {
    case data
    
    public func url(baseURL: URL) -> URLRequest {
        switch self {
        case .data:
            var components = URLComponents()
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            components.path = baseURL.path + "/herostats"
            
            return URLRequest(url: components.url!)
        }
    }
}
