//
//  CharactersPage.swift
//  assignment32
//
//  Created by nuca on 31.05.24.
//

import SwiftUI
struct CharactersPage: View {
    @ObservedObject var viewModel: CharactersPageViewModel
    
    private let rows = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                listOfCharacters
            }
            .padding()
        }
    }
    
    private var listOfCharacters: some View {
        LazyVGrid(columns: rows, alignment: .listRowSeparatorLeading) {
            ForEach(viewModel.characters ?? [Character]()) { character in
                NavigationLink(destination: detailsView(of: character)) {
                    HStack {
                        characterCell(of: character)
                    }
                }
            }
        }
    }
    
    private func characterCell(of character: Character) -> some View {
        HStack {
            image(with: viewModel.imageURL(url: character.image ?? ""))
            
            Text(character.name ?? "name unknown")
                .frame(minWidth: 50)
        }
    }
    
    private func detailsView(of character: Character) -> CharactersDetailsView {
        CharactersDetailsView(
            viewModel: CharactersDetailsViewViewModel(character: character)
        )
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
