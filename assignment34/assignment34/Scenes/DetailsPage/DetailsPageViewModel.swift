//
//  DetailsPageViewModel.swift
//  assignment34
//
//  Created by nuca on 08.06.24.
//

import Foundation
import SwiftData

final class DetailsPageViewModel: ObservableObject {
    private var modelContext: ModelContext
    
    @Published var favoriteMovies: [Movie] = []
    
    var isFavorite: Bool {
        favoriteMovies.contains { movie in
            movie.databaseID == self.movie.databaseID
        }
    }
    
    @Published var overview: String?
    
    var movie: Movie
    
    private func fetchData(with id: String) {
        
        let networkConfiguring = NetworkConfiguring()
        
        NetworkingService.networkService.getData(
            urlString: "https://api.themoviedb.org/3/movie/" + id,
            queryItems: networkConfiguring.queryItems,
            headers: networkConfiguring.headers
        ) {
            (result: Result<Overview, Error>) in
            switch result {
            case .success(let data):
                self.overview = data.overview
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchFromContext() {
        let fetchDescriptor: FetchDescriptor<Movie> = FetchDescriptor()
        favoriteMovies = (try? (modelContext.fetch(fetchDescriptor))) ?? []
    }
    
    func addToFavorites() {
        modelContext.insert(movie)
        
        favoriteMovies.append(movie)
    }
    
    func removeFromFavorites() {
        modelContext.delete(movie)
        
        favoriteMovies.removeAll()
    }
    
    func imageURL(url: String?) -> URL? {
        if url != nil {
            URL(string: "https://image.tmdb.org/t/p/original" + url!)
        } else {
            nil
        }
    }
    
    init(modelContext: ModelContext, movie: Movie) {
        self.modelContext = modelContext
        self.movie = movie
        
        fetchData(with: "\(movie.databaseID ?? 0)")
        fetchFromContext()
    }
}
