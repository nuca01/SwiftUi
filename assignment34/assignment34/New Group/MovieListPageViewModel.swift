//
//  MovieListPageViewModel.swift
//  assignment34
//
//  Created by nuca on 05.06.24.
//

import Foundation

class MovieListPageViewModel: ObservableObject {
    @Published var nowPlaying: Results?
    
    @Published var popular: Results?
    
    @Published var topRated: Results?
    
    func imageURL(url: String) -> URL? {
        URL(string: url)
    }
    
    private func fetchNowPlaying() {
        fetchData(with: "https://api.themoviedb.org/3/movie/now_playing", of: .nowPlaying)
    }
    
    private func fetchPopular() {
        fetchData(with: "https://api.themoviedb.org/3/movie/popular", of: .popular)
    }
    
    private func fetchTopRated() {
        fetchData(with: "https://api.themoviedb.org/3/movie/top_rated", of: .topRated)
    }
    
    private func fetchData(with url: String, of array: ArrayType) {
        
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
                switch array {
                case .nowPlaying:
                    self.nowPlaying = data
                case .popular:
                    self.popular = data
                case .topRated:
                    self.topRated = data
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private enum ArrayType {
        case nowPlaying
        case popular
        case topRated
    }
    
    init() {
        fetchNowPlaying()
        fetchPopular()
        fetchTopRated()
    }
}
