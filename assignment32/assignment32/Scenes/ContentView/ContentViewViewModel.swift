//
//  ContentViewViewModel.swift
//  assignment32
//
//  Created by nuca on 31.05.24.
//

import Foundation
import NetworkingService

final class ContentViewViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var episodes: [Episode] = []

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

    private func fetchEpisodes() {
        NetworkService.networkService.getData(urlString: "https://rickandmortyapi.com/api/episode") { (result: Result<Episodes, Error>) in
            switch result {
            case .success(let data):
                self.episodes = data.results
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
