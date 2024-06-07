//
//  Movie.swift
//  assignment34
//
//  Created by nuca on 05.06.24.
//

import Foundation

struct Movie: Decodable, Identifiable {
    let posterPath: String?
    let title: String?
    let id: Int?
    let voteAverage: Double?
    let genreIds: [Int]?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case id
        case voteAverage = "vote_average"
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
    }
}

enum Genre: Int, CaseIterable {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case scienceFiction = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37

    var name: String {
        switch self {
        case .action: return "Action"
        case .adventure: return "Adventure"
        case .animation: return "Animation"
        case .comedy: return "Comedy"
        case .crime: return "Crime"
        case .documentary: return "Documentary"
        case .drama: return "Drama"
        case .family: return "Family"
        case .fantasy: return "Fantasy"
        case .history: return "History"
        case .horror: return "Horror"
        case .music: return "Music"
        case .mystery: return "Mystery"
        case .romance: return "Romance"
        case .scienceFiction: return "Science Fiction"
        case .tvMovie: return "TV Movie"
        case .thriller: return "Thriller"
        case .war: return "War"
        case .western: return "Western"
        }
    }
    
    static let nameToGenreID: [String: String] = {
        var map = [String: String]()
        for genre in Genre.allCases {
            map[genre.name.lowercased()] = String(genre.rawValue)
        }
        return map
    }()
}
