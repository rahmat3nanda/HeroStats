//
//  HeroLoader.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import Foundation

protocol HeroLoader {
    typealias Result = Swift.Result<[Hero], Error>
    
    func load(skipCache: Bool, completion: @escaping (Result) -> Void)
}

extension HeroLoader {
    func load(_ skipCache: Bool = true, completion: @escaping (Result) -> Void) {
        load(skipCache: skipCache, completion: completion)
    }
}
