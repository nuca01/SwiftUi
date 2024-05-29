//
//  Destination.swift
//  assignment31
//
//  Created by nuca on 29.05.24.
//

import Foundation

struct Destination: Decodable {
    let name: String
    let imageURL: String
    let information: String
    let transports: Transports
    let hotels: [Hotel]
    let mustSee: MustSee
}

struct Transports: Decodable {
    let taxi: Transport
    let subway: Transport
    let bus: Transport
    let tram: Transport
}

struct Transport: Decodable {
    let information: String?
    let available: Bool
}

struct Hotel: Decodable {
    let name: String
    let stars: Int
    let information: String
    let imageURL: String
}

struct MustSee: Decodable {
    let name: String
    let imageURL: String
    let information: String
}
