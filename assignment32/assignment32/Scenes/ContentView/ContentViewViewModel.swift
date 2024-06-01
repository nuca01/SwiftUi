//
//  ContentViewViewModel.swift
//  assignment32
//
//  Created by nuca on 31.05.24.
//

import Foundation
import NetworkingService

import Combine
final class ContentViewViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var episodes: [Episode] = []
    
    @Published var searchResultsCharacters: [Character] = []
    @Published var searchResultsEpisodes: [Episode] = []
    
    @Published var searchQuery: String = ""
    @Published var searchScope: SearchScope = .both
    
    enum SearchScope {
        case characters, episodes, both
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchQuery
            .combineLatest($searchScope)
            .sink { [weak self] query, scope in
                self?.search(query: query, scope: scope)
            }
            .store(in: &cancellables)
    }
    
    private func search(query: String, scope: SearchScope) {
        guard !query.isEmpty else {
            searchResultsCharacters = []
            searchResultsEpisodes = []
            return
        }
        
        let lowercasedQuery = query.lowercased()
        
        switch scope {
        case .characters:
            searchResultsCharacters = characters.filter { $0.name!.lowercased().contains(lowercasedQuery) }
            searchResultsEpisodes = []
        case .episodes:
            searchResultsEpisodes = episodes.filter { $0.name!.lowercased().contains(lowercasedQuery) }
            searchResultsCharacters = []
        case .both:
            searchResultsCharacters = characters.filter { $0.name!.lowercased().contains(lowercasedQuery) }
            searchResultsEpisodes = episodes.filter { $0.name!.lowercased().contains(lowercasedQuery) }
        }
    }
    
    private func fetchCharacters() {
        NetworkService.networkService.getData(urlString: "https://rickandmortyapi.com/api/character") { (result: Result<[Character], Error>) in
            switch result {
            case .success(let data):
                self.characters = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func fetchEpisodes() {
        NetworkService.networkService.getData(urlString: "https://rickandmortyapi.com/api/episode") { (result: Result<[Episode], Error>) in
            switch result {
            case .success(let data):
                self.episodes = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func imageURL(url: String) -> URL? {
        URL(string: url)
    }
}
