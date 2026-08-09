//
//  NewsViewModel.swift
//  DiffableNewsScroller
//
//  Created by Vladislav Mishukov on 08.08.2026.
//

import Foundation
import Combine

final class NewsViewModel {
    
    @Published private(set) var newsItems: [NewsItem] = []
    @Published private(set) var errorMessage: String? = nil
    
    private var fetchedNews: [NewsModel]?
    init() {
        fetchNews()
    }
}

// MARK: - Private Methods
private extension NewsViewModel {
    
    func fetchNews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            self?.fetchedNews = NewsModel.makeMockData()
            self?.updateNewsItems()
        }
    }
    
    func updateNewsItems() {
        guard let fetchedNews else { return }
        newsItems = fetchedNews.map { NewsItem(title: $0.title,
                                               description: $0.description,
                                               image: nil,
                                               categoryType: $0.categoryType,
                                               dateInfo: $0.publishedDate)
        }
    }
}
