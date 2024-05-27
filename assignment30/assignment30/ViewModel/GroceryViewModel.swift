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
    
    @Published var isDiscountApplied: Bool = false
    
    @Published private var products: [Product] = [
        Product(name: "Apple", price: 0.99, imageName: "apple", type: .Fruit, stock: 0),
        Product(name: "Banana", price: 0.59, imageName: "banana", type: .Fruit, stock: 15),
        Product(name: "Carrot", price: 2.35, imageName: "carrot", type: .Vegetable, stock: 12)
    ]
    
    var totalCost: Double {
        let total = cart.reduce(0) { $0 + ($1.key.price * Double($1.value)) }
        return isDiscountApplied ? total * 0.8 : total
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
        cart[product] = cart[product]! - 1
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
    
    func isNotInCart(product: Product) -> Bool {
        cart[product, default: 0] == 0
    }
    
    func toggleDiscount() {
        products = products.map {
            var product = $0
            product.price = product.price * 0.8
            return product
        }
        isDiscountApplied.toggle()
    }
}
