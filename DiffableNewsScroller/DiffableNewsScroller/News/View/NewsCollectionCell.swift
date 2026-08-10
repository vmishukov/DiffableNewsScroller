//
//  NewsCollectionCell.swift
//  DiffableNewsScroller
//
//  Created by Vladislav Mishukov on 08.08.2026.
//

import UIKit

final class NewsCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: NewsCollectionCell.self)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title label"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "It’s important for SEOs and marketers to know that, with the recent update to Google News, Google has ended support for Editors’ Picks feeds and the standout meta tag."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Business"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.backgroundColor = .systemBlue
        return label
    }()
    
    private lazy var dateInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "7 hours ago"
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Public Methods
extension NewsCollectionCell {
    
    func configureCell(with item: NewsItem) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        categoryLabel.text = item.categoryType
        imageView.image = item.image
        dateInfoLabel.text = item.dateInfo
    }
    
}

// MARK: - Private Extension
private extension NewsCollectionCell {
    
    func setupCell() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateInfoLabel)
        contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
            
            dateInfoLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            dateInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateInfoLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: dateInfoLabel.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3)
        ])
    }
    
}
