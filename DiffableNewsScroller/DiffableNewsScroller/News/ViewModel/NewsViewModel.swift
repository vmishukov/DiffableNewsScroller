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
    @Published private(set) var selectedNewsUrl: URL? = nil
    
    private var fetchedNews: [NewsModel] = []
    private let newsService: NewsServiceProtocol
    private let imageService: ImageServiceProtocol
    private var currentNewsPage = 1
    private var isLoading = false
    
    init(newsService: NewsServiceProtocol, imageService: ImageServiceProtocol) {
        self.imageService = imageService
        self.newsService = newsService
        fetchNews()
    }
}

// MARK: - Public Methods
extension NewsViewModel {
    
    func didReachEndOfNews() {
        guard !isLoading else { return }
        fetchNews()
    }
    
    func didSelectNews(at index: Int) {
        guard let selectedNewsUrlString = fetchedNews[safe: index]?.fullUrl else { return }
        selectedNewsUrl = URL(string:selectedNewsUrlString)
    }
}

// MARK: - Private Methods
private extension NewsViewModel {
    
    func fetchNews() {
        isLoading = true
        Task {
            defer { isLoading = false }
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
                                                  dateInfo: formatDateForItem($0.publishedDate ?? ""))
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
    
    func formatDateForItem(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let date = dateFormatter.date(from: dateString) else {
            return dateString
        }

        let calendar = Calendar.current

        if calendar.isDateInToday(date) || calendar.isDateInYesterday(date) {
            let relativeFormatter = RelativeDateTimeFormatter()
            relativeFormatter.locale = Locale(identifier: "ru_RU")
            relativeFormatter.dateTimeStyle = .numeric

            return relativeFormatter.localizedString(
                for: date,
                relativeTo: Date()
            ).capitalized
        }

        let absoluteFormatter = DateFormatter()
        absoluteFormatter.locale = Locale(identifier: "ru_RU")
        absoluteFormatter.dateFormat = "dd.MM.yyyy"

        return absoluteFormatter.string(from: date)
    }

}
