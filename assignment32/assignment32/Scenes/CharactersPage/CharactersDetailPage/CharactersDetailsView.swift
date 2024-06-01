//
//  CharactersDetailsView.swift
//  assignment32
//
//  Created by nuca on 01.06.24.
//

import SwiftUI

struct CharactersDetailsView: View {
    @ObservedObject var viewModel: CharactersDetailsViewViewModel
    var body: some View {
        ScrollView {
            VStack {
                Text("name : \(viewModel.character.name ?? "name unavailable")")
                Text("gender: \(viewModel.character.gender ?? "gender unavailable")")
                Text("origin: \(viewModel.character.origin?.name  ?? "origin unavailable")")
                Text("status: \(viewModel.character.status ?? "status unavailable")")
                Text("species: \(viewModel.character.species ?? "species unavailable")")
                Text("type: \(viewModel.character.type ?? "type unavailable")\n")
                
                Text("episodes:")
                
                LazyVStack {
                    ForEach(viewModel.episodes) { episode in
                        Text(episode.name ?? "name for the episode unavailable")
                    }
                }
            }
        }
    }
}
