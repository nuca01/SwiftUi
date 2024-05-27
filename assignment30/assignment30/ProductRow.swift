//
//  ProductRow.swift
//  assignment30
//
//  Created by nuca on 27.05.24.
//

import SwiftUI

struct ProductRow: View {
    //MARK: - Properties
    @ObservedObject private var viewModel: GroceryViewModel
    
    private var product: Product
    
    var body: some View {
        HStack {
            productImage
            
            productInformation
            
            Spacer()
            
            cartActions()
        }
        .padding()
    }
    
    private var productImage: some View {
        Image(product.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
    }
    
    private var productInformation: some View {
        VStack(alignment: .leading) {
            Text(product.name)
                .font(.headline)
                .foregroundStyle(colorDependingOnStock())
            
            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
                .foregroundStyle(colorDependingOnStock())
        }
    }
    
    private var removeButton: some View {
        Button(action: {
            viewModel.removeFromCart(product: product)
        }) {
            Image(systemName: "minus.circle")
        }
        .disabled(viewModel.isNotInCart(product: product))
    }
    
    private var addButton: some View {
        Button(action: {
            viewModel.addToCart(product: product)
        }) {
            Image(systemName: "plus.circle")
        }
        .disabled(viewModel.notInStock(product: product))
    }
    
    private var deleteButton: some View {
        Button(action: {
            viewModel.deleteFromCart(product: product)
        }) {
            Image(systemName: "trash")
        }
        .disabled(viewModel.isNotInCart(product: product))
    }
    
    //MARK: - Methods
    private func cartActions() -> some View {
        HStack {
            removeButton
            
            Text("\(viewModel.numberOfItems(of: product))")
            
            addButton
            
            deleteButton
        }
    }
    
    private func colorDependingOnStock() -> Color {
        viewModel.notInStock(product: product) ? Color.gray : Color.accentColor
    }
    //MARK: - Initializers
    init(viewModel: GroceryViewModel, product: Product) {
        self.viewModel = viewModel
        self.product = product
    }
}
