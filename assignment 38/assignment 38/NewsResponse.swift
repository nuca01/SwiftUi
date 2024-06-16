//
//  NewsResponse.swift
//  assignment 38
//
//  Created by nuca on 16.06.24.
//

import Foundation

struct NewsResponse: Codable {
    let data: [NewsItem]
}

struct NewsItem: Codable, Identifiable {
    let id: String?
    let title: String?
    let description: String?
    let url: String?
    let imageUrl: String?
    let publishedAt: String?
    let source: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case title
        case description
        case url
        case imageUrl = "image_url"
        case publishedAt = "published_at"
        case source
    }
}
