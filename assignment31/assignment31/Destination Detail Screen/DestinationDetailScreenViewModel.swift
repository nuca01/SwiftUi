//
//  DestinationDetailScreenViewModel.swift
//  assignment31
//
//  Created by nuca on 30.05.24.
//

import Foundation

final class DestinationDetailScreenViewModel {
    var destination: Destination
    
    var imageURL: URL? {
        URL(string: destination.imageURL)
    }
    
    init(destination: Destination) {
        self.destination = destination
    }
}
