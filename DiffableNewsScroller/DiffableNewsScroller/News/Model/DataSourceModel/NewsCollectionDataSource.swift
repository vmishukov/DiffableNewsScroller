//
//  NewsCollectionDataSource.swift
//  DiffableNewsScroller
//
//  Created by Vladislav Mishukov on 09.08.2026.
//

import UIKit

final class NewsCollectionDataSource: UICollectionViewDiffableDataSource<NewsSection, NewsItem> {
    
    func applySnapshot(items: [NewsItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<NewsSection, NewsItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        apply(snapshot)
    }
 }
