//
//  HTPPClient.swift
//  Networking
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import Foundation

public protocol HTTPClient {
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    @discardableResult
    func request(from request: URLRequest) async throws -> (Data, HTTPURLResponse)
}
