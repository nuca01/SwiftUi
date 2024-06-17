//
//  NewsItemView.swift
//  assignment 38
//
//  Created by nuca on 17.06.24.
//

import Foundation
import UIKit

import ImageService

class NewsDetailViewController: UIViewController {
    var newsItem: NewsItem?

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let imageView = UIImageView()
    private let publishedAtLabel = UILabel()
    private let sourceLabel = UILabel()
    private let wholeStack = UIStackView()
    private let scrollView = UIScrollView()
    private let someView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        configureViews()
    }

    
    override func viewDidLayoutSubviews() {
        let stackHeight = titleLabel.bounds.height +
                              imageView.bounds.height +
                              descriptionLabel.bounds.height +
                              publishedAtLabel.bounds.height +
                              sourceLabel.bounds.height
            
            // Set the contentSize of scrollView
//        scrollView.contentSize = CGSize(width: view.bounds.width, height: 9000)
    }
    private func setupViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        publishedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        wholeStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        someView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.isUserInteractionEnabled = true

        view.addSubview(scrollView)
        scrollView.addSubview(wholeStack)

        configureWholeStackView()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wholeStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            wholeStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            wholeStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            wholeStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            wholeStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
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
    }
    
    private func configureTitleLabel() {
        titleLabel.text = newsItem?.title
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.numberOfLines = 0
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.text = newsItem?.description
        descriptionLabel.numberOfLines = 0
    }
    
    private func configureSourceLabel() {
        sourceLabel.text = "source: " + (newsItem?.source ?? "not available")
        sourceLabel.numberOfLines = 0
    }
    
    private func configurePublishedAt() {
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
        if let imageUrlString = newsItem?.imageUrl {
            ImageService.imageService.loadImageFromURL(imageUrlString) { image in
                self.imageView.image = image
            }
        }
    }
    
    private func configureWholeStackView() {
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
        scrollView.isScrollEnabled = true
    }
    
    private func configureScrollView() {
        
    }
}

import SwiftUI

struct NewsDetailViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: NewsDetailViewController, context: Context) {
        uiViewController.newsItem = newsItem
        uiViewController.viewDidLoad()
        uiViewController.viewDidLayoutSubviews()
    }
    
    @Binding var newsItem: NewsItem
    
    func makeUIViewController(context: Context) -> NewsDetailViewController {
        let viewController = NewsDetailViewController()
        viewController.newsItem = newsItem
        return viewController
    }
}
