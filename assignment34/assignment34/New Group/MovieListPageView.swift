//
//  MovieListPageView.swift
//  assignment34
//
//  Created by nuca on 05.06.24.
//

import SwiftUI

struct MovieListPageView: View {
    @StateObject var viewModel = MovieListPageViewModel()
    var body: some View {
        ScrollView {
            nowPlaying
            topRated
            popular
        }
    }
    
    private var nowPlaying: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleText(with: "Now Playing In Theatres")
            
            movieListOf(movies: viewModel.nowPlaying?.results)
        }
        .padding()
    }
    
    private var topRated: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleText(with: "Top Rated")
            
            movieListOf(movies: viewModel.topRated?.results)
        }
        .padding()
    }
    
    private var popular: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleText(with: "Popular Now")
            
            movieListOf(movies: viewModel.popular?.results)
        }
        .padding()
    }
    
    private func titleText(with text: String) -> some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(Color.white)
    }
    private func movieListOf(movies: [Movie]?) -> some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top, spacing: 10) {
                if let movies {
                    ForEach(movies) { movie in
                        MovieCell(movie: movie)
                    }
                }
            }
        }
    }
    
    private func image(with url: String) -> some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(url)")) { image in
            image
                .image?.resizable()
                .scaledToFit()
                .frame(width: 200)
                .clipShape(RoundedRectangle(cornerRadius: 25))
        }
    }
}

#Preview {
    MovieListPageView()
        .background(Color.secondary)
}
