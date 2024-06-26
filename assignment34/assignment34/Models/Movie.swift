//
//  Movie.swift
//  assignment34
//
//  Created by nuca on 05.06.24.
//

import Foundation
import SwiftData

@Model
class Movie: Decodable, Identifiable {
    let posterPath: String?
    let title: String?
    let databaseID: Int?
    let voteAverage: Double?
    let genreIds: [Int]?
    let releaseDate: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case databaseID = "id"
        case voteAverage = "vote_average"
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
    }
    
    init(posterPath: String?, title: String?, databaseID: Int?, voteAverage: Double?, genreIds: [Int]?, releaseDate: String?, backdropPath: String?) {
        self.posterPath = posterPath
        self.title = title
        self.databaseID = databaseID
        self.voteAverage = voteAverage
        self.genreIds = genreIds
        self.releaseDate = releaseDate
        self.backdropPath = backdropPath
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.posterPath = try container.decode(String?.self, forKey: .posterPath)
        self.title = try container.decode(String?.self, forKey: .title)
        self.genreIds = try container.decode([Int]?.self, forKey: .genreIds)
        self.releaseDate = try container.decode(String?.self, forKey: .releaseDate)
        self.backdropPath = try container.decode(String?.self, forKey: .backdropPath)
        self.voteAverage = try container.decode(Double?.self, forKey: .voteAverage)
        self.databaseID = try container.decode(Int?.self, forKey: .databaseID)
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
}
