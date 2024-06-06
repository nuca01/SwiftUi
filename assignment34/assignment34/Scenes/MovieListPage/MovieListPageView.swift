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
        ScrollView {
            nowPlaying
            topRated
            popular
        }
    }
    
    private var nowPlaying: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleText(with: "Now Playing In Theatres")
            
            MoviesList(movies: viewModel.nowPlaying)
        }
        .padding()
    }
    
    private var topRated: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleText(with: "Top Rated")
            
            MoviesList(movies: viewModel.topRated)
        }
        .padding()
    }
    
    private var popular: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleText(with: "Popular Now")
            
            MoviesList(movies: viewModel.popular)
        }
        .padding()
    }
    
    //MARK: - Methods
    private func titleText(with text: String) -> some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(Color.white)
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
