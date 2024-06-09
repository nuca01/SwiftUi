//
//  DetailsPageViewModel.swift
//  assignment34
//
//  Created by nuca on 08.06.24.
//

import Foundation

final class DetailsPageViewModel: ObservableObject {
    @Published var overview: String?
    
    var movie: Movie
    
    private func fetchData(with id: String) {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US")
        ]
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ODRhNjIxNjY0NjZlZjc1NzYwNzQ5MjgyMmE3MmJkOSIsInN1YiI6IjY2NjBhZDU4ZTg1NjZiNmE4Y2EyMjhlMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7cIzniNLbg7LZB5Z-IjJP7Ftd_dI9F8863UEsREQ0yk"
        ]
        
        NetworkingService.networkService.getData(
            urlString: "https://api.themoviedb.org/3/movie/" + id,
            queryItems: queryItems,
            headers: headers
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
    
    func imageURL(url: String?) -> URL? {
        if url != nil {
            URL(string: "https://image.tmdb.org/t/p/original" + url!)
        } else {
            nil
        }
    }
    
    init(movie: Movie) {
        self.movie = movie
        fetchData(with: "\(movie.id ?? 0)")
    }
}
