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

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .connectivity: return "Tidak ada koneksi internet"
        case .invalidData: return "Gagal memuat data"
        case .response(let networkErrorResponse): return networkErrorResponse.error ?? "Terjadi Kesalahan"
        }
    }
}
