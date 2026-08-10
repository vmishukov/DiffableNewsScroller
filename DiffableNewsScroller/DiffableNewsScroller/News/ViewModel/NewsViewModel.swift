//
//  NewsViewModel.swift
//  DiffableNewsScroller
//
//  Created by Vladislav Mishukov on 08.08.2026.
//

import Foundation
import Combine
import UIKit

final class NewsViewModel {
    
    @Published private(set) var newsItems: [NewsItem] = []
    @Published private(set) var errorMessage: String? = nil
    
    private var fetchedNews: [NewsModel]?
    private let newsService: NewsServiceProtocol
    private let imageService: ImageServiceProtocol
    
    init() {
        let service = NetworkNewsService()
        imageService = service
        newsService = service
        fetchNews()
    }
}

// MARK: - Private Methods
private extension NewsViewModel {
    
    func fetchNews() {
        Task {
            do {
                fetchedNews = try await newsService.fetchNews(with: 1)
                updateNewsItems()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func updateNewsItems() {
        guard let fetchedNews else { return }
        newsItems = fetchedNews.map { NewsItem(newsId: $0.id,
                                               title: $0.title ?? "",
                                               description: $0.description ?? "",
                                               image: nil,
                                               categoryType: $0.categoryType ?? "",
                                               dateInfo: $0.publishedDate ?? "")
        }
        loadImagesIfNeeded()
    }
    
    func loadImagesIfNeeded() {
        let noImagesNews = newsItems.compactMap { $0.image == nil ? $0.newsId : nil }
        let newsToLoadImages = fetchedNews?.filter { noImagesNews.contains($0.id) }
        guard let newsToLoadImages else { return }
        newsToLoadImages.forEach {
            guard let url = URL(string: $0.titleImageUrl ?? "") else { return }
            let newsId = $0.id
            Task {
                do {
                    guard let itemIndex = newsItems.firstIndex(where: {$0.newsId == newsId }) else {
                        return
                    }
                    let data = try await imageService.loadImage(from: url)
                    await MainActor.run {
                        newsItems[itemIndex].image = UIImage(data: data)
                    }
                } catch {
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}
