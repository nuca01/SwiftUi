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
    private func fetchData(with url: String, and queryItem: URLQueryItem) {
        var queryItems: [URLQueryItem] = [
            queryItem,
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ODRhNjIxNjY0NjZlZjc1NzYwNzQ5MjgyMmE3MmJkOSIsInN1YiI6IjY2NjBhZDU4ZTg1NjZiNmE4Y2EyMjhlMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7cIzniNLbg7LZB5Z-IjJP7Ftd_dI9F8863UEsREQ0yk"
        ]
        
        NetworkingService.networkService.getData(
            urlString: "https://api.themoviedb.org/3/search/movie",
            queryItems: queryItems,
            headers: headers
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
        fetchData(
            with: "https://api.themoviedb.org/3/search/movie",
            and: URLQueryItem(name: "query", value: searchQuery)
        )
    }
    
    private func fetchByGenre() {
        fetchData(
            with: "https://api.themoviedb.org/3/discover/movie",
            and: URLQueryItem(name: "with_genres", value: Genre.nameToGenreID[searchQuery])
        )
    }
    
    private func fetchByYear() {
        fetchData(
            with: "https://api.themoviedb.org/3/discover/movie",
            and: URLQueryItem(name: "year", value: searchQuery)
        )
    }
    
    private func addSubscribers() {
        $searchQuery
            .combineLatest($selection)
            .sink { searchText, selectionText  in
                switch selectionText {
                case "Name": self.fetchByName()
                case "Genre": self.fetchByGenre()
                case "Year": self.fetchByYear()
                default: break
                }
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Initializer
    init() {
        addSubscribers()
    }
}
