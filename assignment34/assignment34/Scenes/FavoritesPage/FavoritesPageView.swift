//
//  FavoritesPageView.swift
//  assignment34
//
//  Created by nuca on 09.06.24.
//

import SwiftUI
import SwiftData

struct FavoritesPageView: View {
    //MARK: - Properties
    @ObservedObject private var viewModel: FavouritesPageViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: UIColor.secondarySystemBackground)
                    .edgesIgnoringSafeArea(.all)
                
                if viewModel.movies.isEmpty {
                    noFavoritesExplanation
                } else {
                    MoviesList(viewModel: MoviesListViewModel(movies: viewModel.movies))
                }
            }
            .onAppear(perform: {
                viewModel.fetchFromContext()
            })
        }
    }
    
    var noFavoritesExplanation: some View {
        VStack {
            Text("No favourites yet")
            .font(.headline)
            
            Spacer()
                .frame(height: 10)
            
            Text("All moves marked as favourite will be\nadded here")
            .font(.caption)
            .foregroundStyle(Color.gray)
            .multilineTextAlignment(.center)
            .lineLimit(nil)
        }
    }
    
    //MARK: - Initializer
    init(viewModel: FavouritesPageViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Movie.self, configurations: config)

    return FavoritesPageView(viewModel: FavouritesPageViewModel(modelContext: ModelContext(container)))
        .modelContainer(container)
}
