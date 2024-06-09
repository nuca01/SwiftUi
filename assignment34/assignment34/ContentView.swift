//
//  ContentView.swift
//  assignment34
//
//  Created by nuca on 05.06.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            MovieListPageView(viewModel: MovieListPageViewModel())
                .tabItem { Image("Home") }
            SearchPageView(viewModel: SearchPageViewModel())
                .tabItem { Image("Search 1") }
        }
    }
}

//#Preview {
//    ContentView()
//        .modelContainer(for: Movie.self)
//}
