//
//  Character.swift
//  assignment32
//
//  Created by nuca on 31.05.24.
//

import Foundation

struct Characters {
    var character: [Character]
    let url: String = "
}
struct Character: Decodable, Identifiable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: Origin?
    let url: String?
    let image: String?
}

struct Origin: Decodable {
    let name: String?
}
