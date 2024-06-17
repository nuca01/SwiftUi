//
//  NewsItemView.swift
//  assignment 38
//
//  Created by nuca on 17.06.24.
//

import Foundation
import UIKit

import UIKit

class NewsDetailViewController: UIViewController {
    var newsItem: NewsItem?

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let imageView = UIImageView()
    private let publishedAtLabel = UILabel()
    private let sourceLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        configureViews()
    }

    private func setupViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        publishedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(imageView)
        view.addSubview(publishedAtLabel)
        view.addSubview(sourceLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            publishedAtLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            publishedAtLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            publishedAtLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            sourceLabel.topAnchor.constraint(equalTo: publishedAtLabel.bottomAnchor, constant: 16),
            sourceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sourceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sourceLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    private func configureViews() {
        titleLabel.text = newsItem?.title
        descriptionLabel.text = newsItem?.description
        sourceLabel.text = newsItem?.source

        if let publishedAt = newsItem?.publishedAt {
            let formatter = ISO8601DateFormatter()
            if let date = formatter.date(from: publishedAt) {
                let displayFormatter = DateFormatter()
                displayFormatter.dateStyle = .medium
                displayFormatter.timeStyle = .short
                publishedAtLabel.text = displayFormatter.string(from: date)
            }
        }

        if let imageUrlString = newsItem?.imageUrl, let imageUrl = URL(string: imageUrlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}

import SwiftUI

struct NewsDetailViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: NewsDetailViewController, context: Context) {
        //update wont happen
    }
    
    var newsItem: NewsItem
    
    func makeUIViewController(context: Context) -> NewsDetailViewController {
        let viewController = NewsDetailViewController()
        viewController.newsItem = newsItem
        return viewController
    }
}
