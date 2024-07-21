//
//  CacheHeroLoader.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 20/07/24.
//

import Foundation
import Shared

class CacheHeroLoader: HeroLoader {
    
    private let cache : Caching
    private let key: Cache.Key
    
    typealias Result = HeroLoader.Result
    
    init(cache: Caching, key: Cache.Key) {
        self.cache = cache
        self.key = key
    }
    
    func load(skipCache: Bool, completion: @escaping (Result) -> Void) {
        let data = cache.readData(key: key)
        completion(map(data))
    }
    
    private func map(_ data: Data?) -> Result {
        do {
            let items = try HeroMapper.data(data)
            return .success(items)
        } catch {
            return .failure(error)
        }
    }
}
