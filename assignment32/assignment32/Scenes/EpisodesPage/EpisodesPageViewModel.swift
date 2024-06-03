//
//  EpisodesPageViewModel.swift
//  assignment32
//
//  Created by nuca on 01.06.24.
//

import Foundation
import NetworkingService

final class EpisodesPageViewModel: ObservableObject {
    @Published var episodes: [Episode]?
    
    private func fetchCharacters() {
        NetworkService.networkService.getData(urlString: "https://rickandmortyapi.com/api/episode") { (result: Result<Episodes, Error>) in
            switch result {
            case .success(let data):
                self.episodes = data.results
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    init() {fetchCharacters()}
}
