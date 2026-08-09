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
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "It’s important for SEOs and marketers to know that, with the recent update to Google News, Google has ended support for Editors’ Picks feeds and the standout meta tag."
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "7 hours ago"
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

// MARK: - Private Extension
private extension NewsCollectionCell {
    
    func setupCell() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textLabel)
        contentView.addSubview(dateInfoLabel)
        contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
            
            dateInfoLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor),
            dateInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateInfoLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
            
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3)
            
        ])
    }
    
}
