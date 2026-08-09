//
//  NewsItem.swift
//  DiffableNewsScroller
//
//  Created by Vladislav Mishukov on 09.08.2026.
//

import Foundation
import UIKit

nonisolated struct NewsItem: Hashable {
    
    let identifier = UUID()
    var title: String
    var description: String
    var image: UIImage?
    var categoryType: String
    var dateInfo: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
