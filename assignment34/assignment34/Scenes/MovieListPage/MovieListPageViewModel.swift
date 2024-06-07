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
    func imageURL(url: String) -> URL? {
        URL(string: url)
    }
    
    private func fetchData(with url: String) {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ODRhNjIxNjY0NjZlZjc1NzYwNzQ5MjgyMmE3MmJkOSIsInN1YiI6IjY2NjBhZDU4ZTg1NjZiNmE4Y2EyMjhlMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7cIzniNLbg7LZB5Z-IjJP7Ftd_dI9F8863UEsREQ0yk"
        ]
        
        NetworkingService.networkService.getData(
            urlString: url,
            queryItems: queryItems,
            headers: headers
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
