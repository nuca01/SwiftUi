//
//  MovieListPageView.swift
//  assignment34
//
//  Created by nuca on 05.06.24.
//

import SwiftUI

struct MovieListPageView: View {
    //MARK: - Properties
    @StateObject var viewModel = MovieListPageViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            Text("Movies")
                .font(.largeTitle)
            
            ScrollView {
                nowPlaying
                topRated
                popular
            }
        }
        .padding()
        .background(Color.pink.opacity(0.2))
    }
    
    private var nowPlaying: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleText(with: "Now Playing In Theatres")
            
            movieList(movies: viewModel.nowPlaying)
        }
    }
    
    private var topRated: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleText(with: "Top Rated")
            
            movieList(movies: viewModel.topRated)
        }
    }
    
    private var popular: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleText(with: "Popular Now")
            
            movieList(movies: viewModel.popular)
        }
    }

    //MARK: - Methods
    private func titleText(with text: String) -> some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
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
    
    private func movieList(movies: [Movie]?) -> some View{
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top, spacing: 10) {
                if let movies {
                    ForEach(movies) { movie in
                        MovieCell(movie: movie)
                            .frame(width: 200, height: 400)
                    }
                }
            }
        }
    }
}

#Preview {
    MovieListPageView()
}
