//
//  Destination.swift
//  assignment31
//
//  Created by nuca on 29.05.24.
//

import Foundation

struct identifiableDestination: Hashable, Identifiable {
    let id: Int
    let destination: Destination
    static var idCounter = 0
    
    init(destination: Destination) {
        self.id = identifiableDestination.idCounter
        self.destination = destination
        identifiableDestination.idCounter += 1
    }
}

struct Destination: Decodable, Hashable {
    let name: String
    let imageURL: String
    let information: String
    let transports: Transports
    let hotels: [Hotel]
    let mustSee: MustSee
}

struct Transports: Decodable, Hashable {
    let taxi: Transport
    let subway: Transport
    let bus: Transport
    let tram: Transport
}

struct Transport: Decodable, Hashable {
    let information: String?
    let available: Bool
}

struct Hotel: Decodable, Hashable {
    let name: String
    let stars: Int
    let information: String
    let imageURL: String
}

struct MustSee: Decodable, Hashable {
    let name: String
    let imageURL: String
    let information: String
}
