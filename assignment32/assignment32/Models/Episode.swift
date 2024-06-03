//
//  Episode.swift
//  assignment32
//
//  Created by nuca on 31.05.24.
//

import Foundation

struct Episodes: Decodable {
    let results: [Episode]
}
struct Episode: Decodable, Identifiable {
    let id: Int?
    let name: String?
    let airDate: String?
    let episode: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
    }
}
