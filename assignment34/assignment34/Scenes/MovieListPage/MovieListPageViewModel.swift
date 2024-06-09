//
//  MovieListPageViewModel.swift
//  assignment34
//
//  Created by nuca on 05.06.24.
//

import Foundation

final class MovieListPageViewModel: ObservableObject {
    //MARK: - Properties
    @Published var moviesList: [Movie]?
    
    //MARK: - Methods
    private func fetchData(with url: String) {
        let networkConfiguring = NetworkConfiguring(queryItems: [
            URLQueryItem(name: "page", value: "1")
        ])
        
        NetworkingService.networkService.getData(
            urlString: url,
            queryItems: networkConfiguring.queryItems,
            headers: networkConfiguring.headers
        ) {
            (result: Result<Results, Error>) in
            switch result {
            case .success(let data):
                self.moviesList = data.results
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func imageURL(url: String?) -> URL? {
        if url != nil {
            URL(string: "https://image.tmdb.org/t/p/w500" + url!)
        } else {
            nil
        }
    }
    
    //MARK: - Enum
    private enum ArrayType {
        case nowPlaying
        case popular
        case topRated
    }
    
    //MARK: - Initializer
    init() {
        fetchData(with: "https://api.themoviedb.org/3/discover/movie")
    }
}
