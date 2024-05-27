//
//  GroceryViewModel.swift
//  assignment30
//
//  Created by nuca on 27.05.24.
//

import Foundation

final class GroceryViewModel: ObservableObject {
    //MARK: - Properties
    @Published private var cart: [Product: Int] = [:]
    
    private let products: [Product] = [
        Product(name: "Apple", price: 0.99, imageName: "apple", type: .Fruit, stock: 0),
        Product(name: "Banana", price: 0.59, imageName: "banana", type: .Fruit, stock: 15),
        Product(name: "Carrot", price: 2.35, imageName: "carrot", type: .Vegetable, stock: 12)
    ]
    
    var totalCost: Double {
        cart.reduce(0) { $0 + ($1.key.price * Double($1.value)) }
    }
    
    var numberOfProducts: Int {
        products.count
    }
    
    var totalItems: Int {
        cart.values.reduce(0, +)
    }
    
    //MARK: - Methods
    func addToCart(product: Product) {
        cart[product, default: 0] += 1
    }
    
    func removeFromCart(product: Product) {
        if let count = cart[product], count >= 1 {
            cart[product] = count - 1
        }
    }
    
    func deleteFromCart(product: Product) {
        cart[product] = 0
    }
    
    func numberOfItems(of product: Product) -> Int {
        cart[product, default: 0]
    }
    
    func productsOf(type: ProductType) -> [Product] {
        products.filter{$0.type == type}
    }
    
    func notInStock(product: Product) -> Bool {
        product.stock == cart[product, default: 0]
    }
}
