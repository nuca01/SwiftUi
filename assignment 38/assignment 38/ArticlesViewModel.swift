//
//  ArticlesViewModel.swift
//  assignment 38
//
//  Created by nuca on 16.06.24.
//

import Foundation
import NetworkingService

class ArticlesViewModel: ObservableObject {
    @Published var articles: [NewsItem] = []
    @Published var selectedRow: NewsItem? = nil
    
    func fetchArticles() {
        NetworkService.networkService.getData(urlString: "https://api.thenewsapi.com/v1/news/all?api_token=xaJEv39wb8EcA0Y3VswUR0DjJZBsqifPv6YITFqF&language=en&limit=3") { (result: Result<NewsResponse, Error>) in
            switch result {
            case .success(let data):
                self.articles = data.data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
