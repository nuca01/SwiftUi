//
//  SearchPageView.swift
//  assignment32
//
//  Created by nuca on 01.06.24.
//

import SwiftUI

struct SearchPageView: View {
    @ObservedObject var viewModel: SearchPageViewModel
    var body: some View {
        NavigationStack{
            ScrollView{
                charactersList
                
                Divider()
                
                episodesList
            }
        }
        .searchable(text: $viewModel.searchQuery, placement: .automatic, prompt: "search for something")
        .searchScopes($viewModel.searchScope) {
            ForEach(viewModel.scopes, id: \.self) { scope in
                Text(scope.title)
            }
        }
        .onChange(of: viewModel.searchScope) {
            viewModel.searchQuery = ""
        }
    }
    
    private var charactersList: some View {
        LazyVStack {
            Text("characters: ")
                .font(.title)
            ForEach(viewModel.searchResultsCharacters) { character in
                characterCell(with: character)
            }
        }
    }
    
    private var episodesList: some View {
        LazyVStack {
            Text("episodes:")
                .font(.title)
            ForEach(viewModel.searchResultsEpisodes) { episode in
                HStack {
                    Text(episode.name ?? "episode name unknown")
                        .frame(minWidth: 50)
                }
            }
        }
    }
    
    private func characterCell(with character: Character) -> some View {
        HStack {
            image(with: viewModel.imageURL(url: character.image ?? ""))
            
            Text(character.name ?? "name unknown")
                .frame(minWidth: 50)
        }
    }
    private func image(with url: URL?) -> some View {
        AsyncImage(url: url) { image in
            image
                .image?.resizable()
                .frame(width: 70, height: 70)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 25))
        }
    }
}

#Preview {
    SearchPageView(viewModel: SearchPageViewModel())
}
