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
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Movies")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ScrollView {
                moviesGrid
            }
        }
        .padding()
        .background(Color(uiColor: UIColor.secondarySystemBackground))
    }
    
    var moviesGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                if let movies = viewModel.moviesList {
                    ForEach(movies) { movie in
                        MovieCell(movie: movie)
                    }
                }
            }
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

//MARK: - MovieCell
struct MovieCell: View {
    private let movie: Movie
    
    var body: some View {
        VStack(alignment: .center) {
            image(with: movie.posterPath ?? "")
            
            Text(movie.title ?? "title unavailable")
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
            
            Spacer()
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
                 .fixedSize()
         }
     }

     init(movie: Movie) {
         self.movie = movie
     }
 }

#Preview {
    MovieListPageView()
}
