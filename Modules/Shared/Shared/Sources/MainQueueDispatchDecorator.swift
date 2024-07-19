//
//  MainQueueDispatchDecorator.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import Foundation

public final class MainQueueDispatchDecorator<T> {
    
    private(set) public var decoratee: T
    
    public init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    public func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        
        completion()
    }
}

