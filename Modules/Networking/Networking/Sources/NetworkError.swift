//
//  NetworkError.swift
//  Networking
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import Foundation

public struct NetworkErrorResponse: Codable {
    public let error: String?
}

public enum NetworkError: Error {
    case connectivity
    case invalidData
    case response(NetworkErrorResponse)
}
