//
//  MovieListPageView.swift
//  assignment34
//
//  Created by nuca on 05.06.24.
//

import SwiftUI

struct MovieListPageView: View {
    //MARK: - Properties
    @ObservedObject private var viewModel: MovieListPageViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                title
                
                moviesGrid
            }
            .padding()
            .background(Color(uiColor: UIColor.secondarySystemBackground))
        }
    }
    
    private var title: some View {
        Text("Movies")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    private var moviesGrid: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 20
            ) {
                if let movies = viewModel.moviesList {
                    ForEach(movies) { movie in
                        NavigationLink(destination: {
                            DetailsPageView(viewModel: DetailsPageViewModel(movie: movie))
                        }) {
                            MovieCell(
                                titleString: movie.title,
                                url: viewModel.imageURL(url: movie.posterPath)
                            )
                                .foregroundStyle(Color(uiColor: UIColor.label))
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Initializer
    init(viewModel: MovieListPageViewModel) {
        self.viewModel = viewModel
    }
}

//MARK: - MovieCell
struct MovieCell: View {
    private let titleString: String?
    
    private let url: URL?
    
    var body: some View {
        VStack(alignment: .center) {
            image
            
            title
            
            Spacer()
        }
    }
    
    private var title: some View {
        Text(titleString ?? "title unavailable")
            .font(.headline)
            .multilineTextAlignment(.center)
            .lineLimit(nil)
    }
    
    private var image: some View {
        AsyncImage(url: url) { image in
            image
                 .resizable()
                 .scaledToFit()
                 .clipShape(RoundedRectangle(cornerRadius: 25))
         } placeholder: {
             VStack() {
                 Spacer()
                 
                 if url != nil {
                     ProgressView()
                         .fixedSize()
                 } else {
                     Image(systemName: "xmark")
                 }
                 
                 Spacer()
             }
             .frame(minHeight: 160)
         }
     }

    //MARK: - Initializer
    init(titleString: String?, url: URL?) {
        self.titleString = titleString
        self.url = url
    }
 }

#Preview {
    MovieListPageView(viewModel: MovieListPageViewModel())
}
