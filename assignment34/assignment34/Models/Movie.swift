//
//  Movie.swift
//  assignment34
//
//  Created by nuca on 05.06.24.
//

import Foundation

struct Results: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Identifiable {
    let posterPath: String
    let title: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case id
    }
}
