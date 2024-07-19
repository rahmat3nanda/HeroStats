//
//  URLSessionHTTPClient.swift
//  Networking
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation : Error {}
    
    public func request(from request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        
        if Task.isCancelled {
            try Task.checkCancellation()
        }
        
        let task = Task {
            do {
                let (data, response) = try await session.data(for: request)
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw UnexpectedValuesRepresentation()
                }
                
                return (data, httpResponse)
                
            } catch {
                throw error
            }
        }
        
        return try await withTaskCancellationHandler {
            try await task.value
        } onCancel: {
            task.cancel()
        }
    }
}
