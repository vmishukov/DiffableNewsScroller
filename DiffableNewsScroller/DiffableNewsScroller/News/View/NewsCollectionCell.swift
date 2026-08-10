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
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: isIpad ? 30 : 20, weight: .bold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: isIpad ? 26 : 16, weight: .regular)
        label.layer.opacity = 0.8
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Business"
        label.font = .systemFont(ofSize: isIpad ? 26 : 16, weight: .medium)
        return label
    }()
    
    private lazy var dateInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: isIpad ? 24 : 14, weight: .light)
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var blankView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.backgroundColor = .systemGray3
        return view
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
        dateInfoLabel.text = item.dateInfo
        
        if item.imageIsNeeded {
            imageView.isHidden = false
            labelsToContentViewConstraint.isActive = false
            imageViewWidthConstraint.isActive = true
            imageViewTrailingConstraint.isActive = true
            labelsToImageViewConstraint.isActive = true
            
            if let image = item.image {
                imageView.image = image
                blankView.isHidden = true
            } else {
                imageView.image = nil
                blankView.isHidden = false
            }
        } else {
            imageView.isHidden = true
            blankView.isHidden = true
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
        contentView.addSubview(blankView)
    }
    
    func setupConstraints() {
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        imageViewWidthConstraint = imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor,
                                                                    multiplier: isIpad ? 0.5 : 0.4)
        labelsToImageViewConstraint = titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8)
        labelsToContentViewConstraint = titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        imageViewTrailingConstraint = imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            dateInfoLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            dateInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: dateInfoLabel.bottomAnchor),
            
            blankView.topAnchor.constraint(equalTo: imageView.topAnchor),
            blankView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            blankView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            blankView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
        
        [categoryLabel, descriptionLabel, dateInfoLabel].forEach { label in
            label.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        }
    }
    
}
