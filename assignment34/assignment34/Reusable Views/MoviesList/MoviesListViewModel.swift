//
//  MoviesListViewModel.swift
//  assignment34
//
//  Created by nuca on 09.06.24.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    @Published var movies: [Movie]?
    
    func imageURL(url: String?) -> URL? {
        if url != nil {
            URL(string: "https://image.tmdb.org/t/p/w500" + url!)
        } else {
            nil
        }
    }
    
    init(movies: [Movie]?) {
        self.movies = movies
    }
}
