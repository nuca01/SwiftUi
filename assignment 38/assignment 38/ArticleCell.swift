//
//  ArticleCell.swift
//  assignment 38
//
//  Created by nuca on 16.06.24.
//

import UIKit
import ImageService

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

import SwiftUI

extension View {
    @ViewBuilder func scaledFont(name: String = UIFont.systemFont(ofSize: 0).familyName, size: CGFloat, weight: Font.Weight = .regular) -> some View {
      if #available(iOS 16.0, *) {
         self
              .font(.custom(name, size: size, relativeTo: .body))
              .fontWeight(weight)
      } else {
         self
          .font(
            .custom(name, size: size, relativeTo: .body)
            .weight(weight)
          )
      }
    }
}

struct NewsRow: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Binding var newsItem: NewsItem

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: newsItem.imageUrl ?? "")) { image in
                image.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
            }
            .frame(width: 150, height: 150)
            .cornerRadius(8)
            .padding()
            .accessibilityLabel("image describing image")
            Text(newsItem.title ?? "title unavailable")
                .scaledFont(size: 15)
                .lineLimit(nil)
                .accessibilityLabel(newsItem.title ?? "title unavailable")
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
