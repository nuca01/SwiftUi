//
//  CharactersDetailsViewViewModel.swift
//  assignment32
//
//  Created by nuca on 01.06.24.
//

import Foundation
import NetworkingService

final class CharactersDetailsViewViewModel: ObservableObject {
    var character: Character
    
    @Published var episodes: [Episode] = []
    
    func imageURL(url: String) -> URL? {
        URL(string: url)
    }
    
    init(character: Character, episodes: [Episode]) {
        self.character = character
    }
    
    private func fetchEpisodes() {
        for episode in character.episode! {
            NetworkService.networkService.getData(urlString: episode) { (result: Result<Episode, Error>) in
                switch result {
                case .success(let data):
                    self.episodes.append(data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    init(character: Character) {
        self.character = character
        fetchEpisodes()
    }
}
