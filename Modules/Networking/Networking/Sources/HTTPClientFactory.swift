//
//  HTTPClientFactory.swift
//  Networking
//
//  Created by Rahmat Trinanda Pramudya Amar on 20/07/24.
//

import Foundation

public class HTTPClientFactory {
    
    private init() {}
    
    static func makeTimeOutURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10.0
        configuration.timeoutIntervalForResource = 10.0

        return URLSession(configuration: configuration)
    }
    
    public static func makeURLSessionHttpClient() -> HTTPClient {
        return URLSessionHTTPClient(session: makeTimeOutURLSession())
    }
}
