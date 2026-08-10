//
//  ViewController.swift
//  DiffableNewsScroller
//
//  Created by Vladislav Mishukov on 08.08.2026.
//

import UIKit
import Combine

final class NewsViewController: UIViewController {
    
    private lazy var newsCollectionView: UICollectionView = {
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createCollectionLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(NewsCollectionCell.self,
                            forCellWithReuseIdentifier: NewsCollectionCell.reuseIdentifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        return collection
    }()
    
    private var dataSource: NewsCollectionDataSource?
    
    private var cancellables = Set<AnyCancellable>()
    
    private let viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionDataSource()
        setupView()
        setupConstraints()
        bindViewModel()
    }
}

// MARK: - Private Methods
private extension NewsViewController {
    
    func setupView() {
        view.addSubview(newsCollectionView)
        navigationItem.title = "News Scroller"
        view.backgroundColor = .systemBackground
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            newsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func createCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(50))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(50))
            
            let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: containerGroup)
            
            return section
        }
        return layout
    }
    
    func bindViewModel() {
        viewModel.$newsItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateNewsCollection()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.showError(errorMessage)
            }
            .store(in: &cancellables)
    }
    
    func setupCollectionDataSource() {
        dataSource = NewsCollectionDataSource(collectionView: newsCollectionView,
                                              cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionCell.reuseIdentifier, for: indexPath)
            guard let newsCell = cell as? NewsCollectionCell else { return cell }
            newsCell.configureCell(with: item)
            return newsCell
        })
        newsCollectionView.dataSource = dataSource
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    func updateNewsCollection() {
        dataSource?.applySnapshot(items: viewModel.newsItems)
    }
}

// MARK: - UICollectionViewDelegate
extension NewsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row + 1 == viewModel.newsItems.count {
            viewModel.didReachEndOfNews()
        }
    }
}
