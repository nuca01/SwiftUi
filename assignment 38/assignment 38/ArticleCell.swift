//
//  ArticleCell.swift
//  assignment 38
//
//  Created by nuca on 16.06.24.
//

import UIKit
import ImageService

class ArticleCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let titleTextField = UITextField ()
    private let articleImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontForContentSizeCategory = true
        articleImageView.contentMode = .scaleAspectFit
        
        
        contentView.addSubview(articleImageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            articleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            articleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            articleImageView.widthAnchor.constraint(equalToConstant: 100),
            articleImageView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with article: NewsItem) {
        titleLabel.text = article.title
        
        ImageService.imageService.loadImageFromURL(article.imageUrl ?? "") { [weak self] image in
            
            self?.articleImageView.image = image
        }
    }
}
