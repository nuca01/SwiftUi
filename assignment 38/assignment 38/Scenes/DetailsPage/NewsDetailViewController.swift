//
//  NewsDetailViewController.swift
//  assignment 38
//
//  Created by nuca on 17.06.24.
//

import Foundation
import UIKit

import ImageService

class NewsDetailViewController: UIViewController {
    //MARK: - Properties
    var newsItem: NewsItem?

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let imageView = UIImageView()
    private let publishedAtLabel = UILabel()
    private let sourceLabel = UILabel()
    private let wholeStack = UIStackView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViews()
        setupViews()
    }
    
    //MARK: - Methods
    private func setupViews() {
        constrainViews()
    }
    
    private func constrainViews() {
        constrainScrollView()
        constrainWholeStackView()
        constrainImageView()
    }
    
    private func constrainScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func constrainWholeStackView() {
        scrollView.addSubview(wholeStack)
        NSLayoutConstraint.activate([
            wholeStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            wholeStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            wholeStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            wholeStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            wholeStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    private func constrainImageView() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: wholeStack.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func configureViews() {
        configureTitleLabel()
        configureDescriptionLabel()
        configureSourceLabel()
        configurePublishedAt()
        configureImageView()
        configureWholeStackView()
        configureScrollView()
        configureContentView()
    }
    
    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = newsItem?.title
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.numberOfLines = 0
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = newsItem?.description
        descriptionLabel.numberOfLines = 0
    }
    
    private func configureSourceLabel() {
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.text = "source: " + (newsItem?.source ?? "not available")
        sourceLabel.numberOfLines = 0
    }
    
    private func configurePublishedAt() {
        publishedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        publishedAtLabel.numberOfLines = 0
        if let publishedAt = newsItem?.publishedAt {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000000Z"
            if let date = formatter.date(from: publishedAt) {
                publishedAtLabel.text = "date published: " + date.description
            }
        }
    }
    
    private func configureImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let imageUrlString = newsItem?.imageUrl {
            ImageService.imageService.loadImageFromURL(imageUrlString) { image in
                self.imageView.image = image
            }
        }
    }
    
    private func configureWholeStackView() {
        wholeStack.translatesAutoresizingMaskIntoConstraints = false
        wholeStack.axis = .vertical
        wholeStack.distribution = .equalSpacing
        wholeStack.spacing = 20
        
        for view in [
            titleLabel,
            imageView,
            descriptionLabel,
            publishedAtLabel,
            sourceLabel,
        ] {
            wholeStack.addArrangedSubview(view)
        }
    }
    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
    }
    
    private func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
}
