//
//  CharactersPageViewModel.swift
//  assignment32
//
//  Created by nuca on 31.05.24.
//

import Foundation
import NetworkingService

final class CharactersPageViewModel: ObservableObject {
    @Published var characters: [Character]?
    
    func imageURL(url: String) -> URL? {
        URL(string: url)
    }
    
    private func fetchCharacters() {
        NetworkService.networkService.getData(urlString: "https://rickandmortyapi.com/api/character") { (result: Result<Characters, Error>) in
            switch result {
            case .success(let data):
                self.characters = data.results
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    init() {fetchCharacters()}
}
