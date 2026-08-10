//
//  Extensions.swift
//  DiffableNewsScroller
//
//  Created by Vladislav Mishukov on 10.08.2026.
//

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
