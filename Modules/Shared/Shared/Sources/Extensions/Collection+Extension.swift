//
//  Collection+Extension.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 21/07/24.
//

import Foundation

public extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
