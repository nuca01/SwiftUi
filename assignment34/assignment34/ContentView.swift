//
//  ContentView.swift
//  assignment34
//
//  Created by nuca on 05.06.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    
    var body: some View {
        TabView {
            MovieListPageView(viewModel: MovieListPageViewModel())
                .tabItem { Image("Home") }
            SearchPageView(viewModel: SearchPageViewModel())
                .tabItem { Image("Search 1") }
            FavoritesPageView(viewModel: FavouritesPageViewModel(modelContext: context))
                .tabItem { Image("Favourites") }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Movie.self, configurations: config)

    return ContentView()
        .modelContainer(container)
}
