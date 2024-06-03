//
//  ContentView.swift
//  assignment32
//
//  Created by nuca on 31.05.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CharactersPage(viewModel: CharactersPageViewModel())
                .tabItem { Text("characters") }
            EpisodesPage(viewModel: EpisodesPageViewModel())
                .tabItem { Text("episodes") }
            SearchPageView(viewModel: SearchPageViewModel())
                .tabItem { Text("search") }
        }
    }
}

#Preview {
    ContentView()
}
