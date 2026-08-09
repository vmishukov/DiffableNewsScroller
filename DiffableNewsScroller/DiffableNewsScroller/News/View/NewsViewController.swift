//
//  ViewController.swift
//  DiffableNewsScroller
//
//  Created by Vladislav Mishukov on 08.08.2026.
//

import UIKit

class NewsViewController: UIViewController {
    
    private lazy var newsCollectionView: UICollectionView = {
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createCollectionLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(NewsCollectionCell.self,
                            forCellWithReuseIdentifier: NewsCollectionCell.reuseIdentifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        view.backgroundColor = .systemBackground
    }
}

// MARK: - Private Methods
private extension NewsViewController {
    
    func setupView() {
        view.addSubview(newsCollectionView)
        navigationItem.title = "News Scroller"
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
                                                  heightDimension: .fractionalHeight(1.0))
            let itemInsets = NSDirectionalEdgeInsets(top: 10,
                                                     leading: 10,
                                                     bottom: 10,
                                                     trailing: 10)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = itemInsets
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                                   heightDimension: .fractionalHeight(0.4))
            let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: containerGroup)
            
            return section
        }
        return layout
    }
    
}

// MARK: - UICollectionViewDataSource
extension NewsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionCell.reuseIdentifier, for: indexPath)
        
        guard let newsCell = cell as? NewsCollectionCell else {
            return cell
        }
        return newsCell
    }
    
}

// MARK: - UICollectionViewDelegate
extension NewsViewController: UICollectionViewDelegate {
    
}
