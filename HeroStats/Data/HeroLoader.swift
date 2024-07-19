//
//  HeroLoader.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import Foundation

protocol HeroLoader {
    typealias Result = Swift.Result<[Hero], Error>
    
    func upload(completion: @escaping (Result) -> Void)
}
