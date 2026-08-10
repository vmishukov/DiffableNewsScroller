//
//  Assembly.swift
//  DiffableNewsScroller
//
//  Created by Vladislav Mishukov on 10.08.2026.
//

import UIKit

final class Assembly {
    
    static func makeNewsModule() -> UIViewController {
        let networkService = NetworkNewsService()
        let viewModel = NewsViewModel(newsService: networkService,
                                      imageService: networkService)
        let viewController = NewsViewController(viewModel: viewModel)
        return viewController
    }
}
