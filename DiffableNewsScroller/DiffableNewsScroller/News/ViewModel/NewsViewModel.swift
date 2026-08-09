//
//  NewsViewModel.swift
//  DiffableNewsScroller
//
//  Created by Vladislav Mishukov on 08.08.2026.
//

import Foundation
import Combine

final class NewsViewModel {
    
    @Published private(set) var news: [NewsModel] = []
    @Published private(set) var errorMessage: String? = nil
    
    init() {
        fetchNews()
    }
}

// MARK: - Private Methods
private extension NewsViewModel {
    
    func fetchNews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.news = NewsModel.makeMockData()
        }
    }
}
