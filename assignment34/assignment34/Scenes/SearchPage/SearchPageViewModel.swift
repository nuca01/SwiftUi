//
//  SearchPageViewModel.swift
//  assignment34
//
//  Created by nuca on 06.06.24.
//

import Foundation
import Combine

final class SearchPageViewModel: ObservableObject {
    //MARK: - Properties
    @Published var searchQuery: String = ""
    @Published var results: [Movie]?
    @Published var selection: String = "Name"
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Method
    private func fetchData(with url: String, and queryItemArray: [URLQueryItem]) {
        let networkConfiguring = NetworkConfiguring(queryItems: [
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "page", value: "1")
        ] + queryItemArray)
        
        NetworkingService.networkService.getData(
            urlString: url,
            queryItems: networkConfiguring.queryItems,
            headers: networkConfiguring.headers
        ) {
            (result: Result<Results, Error>) in
            switch result {
            case .success(let data):
                self.results = data.results
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchByName() {
        let queries = [URLQueryItem(name: "query", value: searchQuery)]
        
        fetchData(
            with: "https://api.themoviedb.org/3/search/movie",
            and: queries
        )
    }
    
    private func fetchByGenre() {
        
        let queries = [
            URLQueryItem(name: "with_genres", value: nameToGenreID(from: searchQuery.lowercased())),
            URLQueryItem(name: "include_video", value: "false"),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
        ]
        
        fetchData(
            with: "https://api.themoviedb.org/3/discover/movie",
            and: queries
        )
    }
    
    private func fetchByYear() {
        let queries = [
            URLQueryItem(name: "year", value: searchQuery),
            URLQueryItem(name: "include_video", value: "false"),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
        ]
        fetchData(
            with: "https://api.themoviedb.org/3/discover/movie",
            and: queries
        )
    }
    
    private func addSubscribers() {
        $searchQuery
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .combineLatest($selection)
            .sink { searchText, selectionText  in
                if !searchText.isEmpty {
                    switch selectionText {
                    case "Name": self.fetchByName()
                    case "Genre": self.fetchByGenre()
                    case "Year": 
                        if Int(searchText) != nil
                        {
                            self.fetchByYear()
                        } else {
                            self.results = []
                        }
                    default: break
                    }
                } else{
                    self.results = []
                }
            }
            .store(in: &cancellables)
    }
    
    private func nameToGenreID(from name: String) -> String {
        for genre in Genre.allCases {
            if genre.name.lowercased() == name {
                return String(genre.rawValue)
            }
        }
        return "0"
    }
    
    func imageURL(url: String?) -> URL? {
        if url != nil {
            URL(string: "https://image.tmdb.org/t/p/w500" + url!)
        } else {
            nil
        }
    }
    
    //MARK: - Initializer
    init() {
        addSubscribers()
    }
}
