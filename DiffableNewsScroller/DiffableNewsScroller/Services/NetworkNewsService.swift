//
//  NetworkService.swift
//  DiffableNewsScroller
//
//  Created by Vladislav Mishukov on 10.08.2026.
//

import Foundation

enum NetworkEndpoint: String {
    case newsUrl = "https://webapi.autodoc.ru/api/news/"
}

enum NetworkServiceError: Error {
    case invalidURL
    case codeError(code: Int)
}

protocol NewsServiceProtocol {
    func fetchNews(with page: Int) async throws -> [NewsModel]
}

protocol ImageServiceProtocol {
    func loadImage(from url: URL) async throws -> Data
}

final class NetworkNewsService: NewsServiceProtocol {
    
    private let newsCountPerPage = 15
    private let decoder = JSONDecoder()
    private var activeTasks: [URL: Task<Data, Error>] = [:]
    
    func fetchNews(with page: Int) async throws -> [NewsModel] {
        let urlString = "\(NetworkEndpoint.newsUrl.rawValue)/\(page)/\(newsCountPerPage)"
        guard let url = URL(string: urlString) else {
            throw NetworkServiceError.invalidURL
        }
        let data = try await load(from: url)
        return try decoder.decode(NewsResponseModel.self, from: data).news
    }
}

// MARK: - ImageServiceProtocol
extension NetworkNewsService: ImageServiceProtocol {
    
    func loadImage(from url: URL) async throws -> Data {
        if let existingTask = activeTasks[url] {
            return try await existingTask.value
        }
        
        let task = Task {
            defer {
                activeTasks[url] = nil
            }
            return try await load(from: url)
        }
        
        activeTasks[url] = task
        return try await task.value
    }
}

// MARK: - Private Methods
private extension NetworkNewsService {
    
    func load(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse,
           response.statusCode < 200 || response.statusCode >= 300 {
            throw NetworkServiceError.codeError(code: response.statusCode)
        }
        return data
    }
}
