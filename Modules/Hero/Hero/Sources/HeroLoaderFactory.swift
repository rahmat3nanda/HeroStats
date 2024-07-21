//
//  HeroLoaderFactory.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 20/07/24.
//

import Foundation
import Shared
import Networking

public class HeroLoaderFactory {
    
    private init() {}
    
    public static func create() -> HeroLoader {
        let cacheLoader = CacheHeroLoader(cache: Cache.common, key: .hero)
        
        let url = URL(string: APIConstants.instance.apiBaseUrl)!
        let client = HTTPClientFactory.makeURLSessionHttpClient()
        let remoteLoader = RemoteHeroLoader(baseUrl: url, client: client)
        
        let composite = HeroLoaderComposite(
            remoteLoader: remoteLoader,
            cacheLoader: cacheLoader,
            cache: Cache.common,
            key: .hero
        )
        
        return composite
    }
}
