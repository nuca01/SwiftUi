//
//  SearchPageViewModel.swift
//  assignment32
//
//  Created by nuca on 31.05.24.
//

import Foundation
import NetworkingService
import Combine

enum SearchScope {
    case characters, episodes, both, none
    var title : String {
        switch self {
        case .characters:
            return "characters"
        case .episodes:
            return "episodes"
        case .both:
            return "both"
        case .none:
            return "none"
        }
    }
}

final class SearchPageViewModel: ObservableObject{
    
    //MARK: - arrays
    @Published private var characters: [Character] = []
    @Published private var episodes: [Episode] = []
    
    @Published var searchResultsCharacters: [Character] = []
    @Published var searchResultsEpisodes: [Episode] = []
    
    @Published var searchQuery: String = ""
    
    //MARK: - Scope
    @Published var searchScope: SearchScope = .none
    @Published var scopes: [SearchScope] = [.both, .characters, .episodes, .none]
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Initializer
    init() {
        fetchCharacters()
        fetchEpisodes()
        
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
        case .none:
            searchResultsEpisodes = []
            searchResultsCharacters = []
        }
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
    
    func imageURL(url: String) -> URL? {
        URL(string: url)
    }
}
