//
//  Product.swift
//  assignment30
//
//  Created by nuca on 27.05.24.
//

import Foundation

enum ProductType: CaseIterable, Identifiable {
    case Fruit
    case Vegetable
    var id: Self { self }
}

struct Product: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let price: Double
    let imageName: String
    let type: ProductType
    var stock: Int
}
