//
//  MovieCell.swift
//  assignment34
//
//  Created by nuca on 06.06.24.
//

import SwiftUI

struct MovieCell: View {
    private let movie: Movie
    
    var body: some View {
        VStack {
            image(with: movie.posterPath)
            Text(movie.title)
                .font(.headline)
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .frame(width: 200)
        }
    }
    
    private func image(with url: String) -> some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(url)")) { image in
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
    
    init(movie: Movie) {
        self.movie = movie
    }
}
