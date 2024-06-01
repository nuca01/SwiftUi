//
//  CharactersPage.swift
//  assignment32
//
//  Created by nuca on 31.05.24.
//

import SwiftUI

//protocol CharactersPageDelegate: AnyObject {
//    var characters: [Character] {get}
//}
struct CharactersPage: View {
    @ObservedObject var delegate: CharactersPageViewModel
    
    private let rows = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    @State private var isPresentingSheet = false
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: rows, alignment: .listRowSeparatorLeading) {
                    ForEach(delegate.characters ?? [Character]()) { character in
                        
                        Button(action: {
                            isPresentingSheet.toggle()
                        }, label: {
                            HStack {
                                image(with: delegate.imageURL(url: character.image ?? ""))
                                
                                Text(character.name ?? "name unknown")
                                    .frame(minWidth: 50)
                            }
                        })
                        .sheet(isPresented: $isPresentingSheet, content: {
                            CharactersDetailsView(viewModel: CharactersDetailsViewViewModel(character: character))
                        })
                    }
                }
            }
            .padding()
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
    CharactersPage(delegate: CharactersPageViewModel())
}
