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
        NetworkService.networkService.getData(urlString: "https://mocki.io/v1/9467f2c5-600b-4e87-840b-d55d916ed2d6") { (result: Result<[Destination], Error>) in
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
