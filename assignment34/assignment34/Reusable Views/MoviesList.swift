//
//  MoviesList.swift
//  assignment34
//
//  Created by nuca on 06.06.24.
//

import SwiftUI

struct MoviesList: View {
    //MARK: - Properties
    private let movies: [Movie]?
    private let alignment: Axis.Set
    
    var body: some View {
        movieList
    }
    
    @ViewBuilder
    private var movieList: some View {
        if alignment == .horizontal {
            horizontalMovieList()
        } else {
            verticalMovieList()
        }
    }
    
    private func horizontalMovieList() -> some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top, spacing: 10) {
                if let movies {
                    ForEach(movies) { movie in
                        movieCell(with: movie)
                    }
                }
            }
        }
    }
    
    private func verticalMovieList() -> some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .center, spacing: 10) {
                if let movies {
                    ForEach(movies) { movie in
                        movieCell(with: movie)
                    }
                }
            }
        }
    }
        
    private func movieCell(with movie: Movie) -> some View {
        VStack {
            image(with: movie.posterPath)
            title(with: movie.title)
        }
    }
    
    private func image(with urlPath: String) -> some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(urlPath)")) { image in
            image
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 25))
        } placeholder: {
            ProgressView()
        }
        .frame(minHeight: 300)
        .frame(width: 200)
    }
    
    private func title(with title: String) -> some View {
        Text(title)
            .frame(width: 200)
            .multilineTextAlignment(.center)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .font(.headline)
    }
    
    //MARK: - Initializer
    init(movies: [Movie]?, alignment: Axis.Set = .horizontal) {
        self.movies = movies
        self.alignment = alignment
    }
}
