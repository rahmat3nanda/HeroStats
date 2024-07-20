//
//  HeroLoaderComposite.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 20/07/24.
//

import Foundation
import Shared

class HeroLoaderComposite: HeroLoader {
    let remoteLoader: HeroLoader
    let cacheLoader: HeroLoader
    
    let cache: Caching
    let key: Cache.Key
    
    typealias Result = HeroLoader.Result
    
    init(remoteLoader: HeroLoader, cacheLoader: HeroLoader, cache: Caching, key: Cache.Key) {
        self.remoteLoader = remoteLoader
        self.cacheLoader = cacheLoader
        self.cache = cache
        self.key = key
    }
    
    func load(skipCache: Bool, completion: @escaping (Result) -> Void) {
        if skipCache {
            loadFromRemote(completion: completion)
            return
        }
        
        cacheLoader.load { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                self.loadFromRemote(completion: completion)
            }
        }
    }
}

private extension HeroLoaderComposite {
    func loadFromRemote(completion: @escaping (Result) -> Void) {
        remoteLoader.load { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if let data = try? JSONEncoder().encode(success) {
                    self.cache.save(data: data, key: self.key)
                }
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
