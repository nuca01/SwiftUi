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
    
    private let tips = ["Pack light", "Keep a copy of your passport", "Learn basic phrases of the local language"]
    
    //MARK: - Methods
    func fetchDetails() {
        NetworkService.networkService.getData(urlString: "https://mocki.io/v1/24ee674f-56e3-430a-b738-a23a69549032") { (result: Result<[Destination], Error>) in
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
    
    func getRandomTip() -> String {
        tips.randomElement()!
    }
    
    //MARK: - Initializer
    init() {self.fetchDetails()}
    
}
