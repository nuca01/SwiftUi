//
//  SearchPageView.swift
//  assignment34
//
//  Created by nuca on 06.06.24.
//

import SwiftUI

struct SearchPageView: View {
    //MARK: - Properties
    @StateObject var viewModel = SearchPageViewModel()
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
                moviesGrid
                .background(Color.pink.opacity(0.2))
        }
        .searchable(text: $viewModel.searchQuery, placement: .automatic, prompt: "search for a movie")
        .onChange(of: viewModel.searchQuery) {
            viewModel.fetchData()
        }
    }
    
    var moviesGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                if let movies = viewModel.results {
                    ForEach(movies) { movie in
                        MovieCell(movie: movie)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    SearchPageView()
}
