//
//  NewsRow.swift
//  assignment 38
//
//  Created by nuca on 17.06.24.
//

import Foundation
import SwiftUI

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
