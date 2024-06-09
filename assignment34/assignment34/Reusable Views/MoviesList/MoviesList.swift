//
//  MoviesList.swift
//  assignment34
//
//  Created by nuca on 09.06.24.
//

import SwiftUI

struct MoviesList: View {
    @ObservedObject private var viewModel: MoviesListViewModel
    
    private let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        moviesGrid
    }
    
    private var moviesGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: 30) {
                if let movies = viewModel.movies {
                    ForEach(movies) { movie in
                        NavigationLink(destination: {
                            DetailsPageView(viewModel: DetailsPageViewModel(movie: movie))
                        }) {
                            ExtendedMovieCell(
                                movie: movie,
                                url: viewModel.imageURL(url: movie.posterPath)
                            )
                                .foregroundStyle(Color(uiColor: UIColor.label))
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
    }
}
