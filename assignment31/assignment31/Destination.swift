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
    let transports: [Transport]
    let hotels: [Hotel]
    let mustSee: MustSee
}

struct Transport: Decodable {
    let type: String
    let information: String
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
