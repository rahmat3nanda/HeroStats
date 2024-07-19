//
//  RemoteHeroLoader.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import Foundation
import Networking

class RemoteHeroLoader: HeroLoader {
    
    private let baseUrl : URL
    private let client: HTTPClient
    
    typealias Result = HeroLoader.Result
    
    init(baseUrl: URL, client: HTTPClient) {
        self.baseUrl = baseUrl
        self.client = client
    }
    
    func upload(completion: @escaping (Result) -> Void) {
        let request = HeroEndpoint.data.url(baseURL: baseUrl)
        
        Task {
            do {
                let (data, response) = try await client.request(from: request)
                completion(map(data, from: response))
            } catch {
                completion(.failure(NetworkError.connectivity))
            }
        }
    }
    
    private func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let items = try HeroMapper.map(data, from: response)
            return .success(items)
        } catch {
            return .failure(error)
        }
    }
}
