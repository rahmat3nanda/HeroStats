//
//  HeroMapper.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import Foundation
import Networking

final class HeroMapper {
    
    static func remote(_ data: Data, from response: HTTPURLResponse) throws -> [Hero] {
        guard (200...299).contains(response.statusCode) else {
            if let error = try? JSONDecoder().decode(NetworkErrorResponse.self, from: data) {
                throw NetworkError.response(error)
            }
            
            throw NetworkError.connectivity
        }
        
        guard let data = try? JSONDecoder().decode([Hero].self, from: data) else {
            throw NetworkError.invalidData
        }
        
        return data
    }
    
    static func data(_ data: Data?) throws -> [Hero] {
        guard let data = data,
              let data = try? JSONDecoder().decode([Hero].self, from: data) else {
            throw NetworkError.invalidData
        }
        
        return data
    }
}
