//
//  NewsTableViewCell.swift
//  assignment 38
//
//  Created by nuca on 16.06.24.
//

import UIKit
import ImageService
import SwiftUI

class NewsTableViewCell: UITableViewCell {
    private var hostingController: UIHostingController<NewsRow>?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        if hostingController == nil {
            hostingController = UIHostingController(rootView: NewsRow(newsItem: .constant(NewsItem(
                id: nil,
                title: nil,
                description: nil,
                url: nil,
                imageUrl: nil,
                publishedAt: nil,
                source: nil
            ))))
            
            guard let hostingController = hostingController else { return }
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(hostingController.view)
            
            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        }
    }
    
    func configure(with newsItem: Binding<NewsItem>) {
        hostingController?.rootView = NewsRow(newsItem: newsItem)
    }
}
