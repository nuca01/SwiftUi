//
//  SearchPageView.swift
//  assignment34
//
//  Created by nuca on 06.06.24.
//

import SwiftUI

struct SearchPageView: View {
    @StateObject var viewModel = SearchPageViewModel()
    
    var body: some View {
        NavigationStack {
            MoviesList(movies: viewModel.results, alignment: .vertical)
                .background(Color.pink.opacity(0.2))
        }
        .searchable(text: $viewModel.searchQuery, placement: .automatic, prompt: "search for a movie")
        .onChange(of: viewModel.searchQuery) {
            viewModel.fetchData()
        }
    }
}

#Preview {
    SearchPageView()
}
