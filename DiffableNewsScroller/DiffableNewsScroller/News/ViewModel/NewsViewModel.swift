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
    
    private var fetchedNews: [NewsModel] = []
    private let newsService: NewsServiceProtocol
    private let imageService: ImageServiceProtocol
    private var currentNewsPage = 1
    
    init() {
        let service = NetworkNewsService()
        imageService = service
        newsService = service
        fetchNews()
    }
}

// MARK: - Public Methods
extension NewsViewModel {
    
    func didReachEndOfNews() {
        fetchNews()
    }
    
}

// MARK: - Private Methods
private extension NewsViewModel {
    
    func fetchNews() {
        Task {
            do {
                let newlyFetchedNews = try await newsService.fetchNews(with: currentNewsPage)
                currentNewsPage += 1
                fetchedNews.append(contentsOf: newlyFetchedNews)
                updateNewsItems(with: newlyFetchedNews)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func updateNewsItems(with fetchedNews: [NewsModel]) {
        let newItems = fetchedNews.map { NewsItem(newsId: $0.id,
                                                  title: $0.title ?? "",
                                                  description: $0.description ?? "",
                                                  image: nil,
                                                  categoryType: $0.categoryType ?? "",
                                                  dateInfo: $0.publishedDate ?? "")
        }
        newsItems.append(contentsOf: newItems)
        loadImagesIfNeeded(with: newItems)
    }
    
    func loadImagesIfNeeded(with newItems: [NewsItem]) {
        let noImagesNews = newItems.compactMap { $0.image == nil && $0.imageIsNeeded ? $0.newsId : nil }
        let newsToLoadImages = fetchedNews.filter { noImagesNews.contains($0.id) }
        newsToLoadImages.forEach {
            let newsId = $0.id
            guard let itemIndex = newsItems.firstIndex(where: { $0.newsId == newsId }) else {
                return
            }
            guard let url = URL(string: $0.titleImageUrl ?? "") else {
                newsItems[itemIndex].imageIsNeeded = false
                return
            }
            Task {
                do {
                    let data = try await imageService.loadImage(from: url)
                    await MainActor.run {
                        newsItems[itemIndex].image = UIImage(data: data)
                    }
                } catch {
                    newsItems[itemIndex].imageIsNeeded = false
                }
            }
        }
    }
}
