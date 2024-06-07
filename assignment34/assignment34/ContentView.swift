//
//  ContentView.swift
//  assignment34
//
//  Created by nuca on 05.06.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MovieListPageView()
                .tabItem { Image("Home") }
            SearchPageView()
                .tabItem { Image("Search 1") }
        }
    }
}

#Preview {
    ContentView()
}
