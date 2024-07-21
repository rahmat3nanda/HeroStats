//
//  HeroLoader.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import Foundation

public protocol HeroLoader {
    typealias Result = Swift.Result<[HeroItem], Error>
    
    func load(skipCache: Bool, completion: @escaping (Result) -> Void)
}

extension HeroLoader {
    func load(_ skipCache: Bool = true, completion: @escaping (Result) -> Void) {
        load(skipCache: skipCache, completion: completion)
    }
}
