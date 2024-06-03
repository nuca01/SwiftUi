//
//  EpisodesPage.swift
//  assignment32
//
//  Created by nuca on 01.06.24.
//

import SwiftUI

import SwiftUI
struct EpisodesPage: View {
    @ObservedObject var viewModel: EpisodesPageViewModel
    
    private let rows = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                listOfEpisodes
            }
            .padding()
        }
    }
    
    private var listOfEpisodes: some View {
        LazyVGrid(columns: rows, alignment: .center) {
            ForEach(viewModel.episodes ?? [Episode]()) { episode in
                VStack {
                    Text("name: \(episode.name ?? "not available")")
                    Text("air date: \(episode.airDate ?? "not available" )")
                    Text("episode: \(episode.episode ?? "not available" ))")
                }
                Divider()
            }
        }
    }
    
}

#Preview {
    EpisodesPage(viewModel: EpisodesPageViewModel())
}
