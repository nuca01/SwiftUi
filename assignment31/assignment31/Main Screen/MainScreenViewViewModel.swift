//
//  MainScreenViewViewModel.swift
//  assignment31
//
//  Created by nuca on 30.05.24.
//

import Foundation
import NetworkingService

final class MainScreenViewViewModel: ObservableObject {
    @Published var arrayOfDestinations: [Destination] = []
    
    func fetchDetails() {
        NetworkService.networkService.getData(urlString: "https://mocki.io/v1/e1eb584c-2401-4acc-8d5f-d5720de1cc7b") { (result: Result<[Destination], Error>) in
            switch result {
            case .success(let destinations):
                self.arrayOfDestinations = destinations
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func imageURL(for destination: Destination) -> URL? {
        let destinationInArray = arrayOfDestinations.first { $0.name == destination.name }
        return URL(string: destinationInArray?.imageURL ?? "")
    }
    
    init() {self.fetchDetails()}
    
}
