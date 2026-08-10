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
        label.text = "It's important for SEOs and marketers to know that, with the recent update to Google News, Google has ended support for Editors' Picks feeds and the standout meta tag."
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
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var imageViewWidthConstraint: NSLayoutConstraint!
    private var labelsToImageViewConstraint: NSLayoutConstraint!
    private var labelsToContentViewConstraint: NSLayoutConstraint!
    private var imageViewTrailingConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
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
        
        if item.imageIsNeeded {
            imageView.isHidden = false
            labelsToContentViewConstraint.isActive = false
            imageViewWidthConstraint.isActive = true
            imageViewTrailingConstraint.isActive = true
            labelsToImageViewConstraint.isActive = true
        } else {
            imageView.isHidden = true
            imageViewWidthConstraint.isActive = false
            imageViewTrailingConstraint.isActive = false
            labelsToImageViewConstraint.isActive = false
            labelsToContentViewConstraint.isActive = true
        }
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
        
        imageViewWidthConstraint = imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3)
        labelsToImageViewConstraint = titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8)
        labelsToContentViewConstraint = titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        imageViewTrailingConstraint = imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            descriptionLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            dateInfoLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            dateInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dateInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: dateInfoLabel.bottomAnchor)
        ])
        
        [categoryLabel, descriptionLabel, dateInfoLabel].forEach { label in
            label.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        }
    }
    
}
