//
//  ContentView.swift
//  assignment30
//
//  Created by nuca on 27.05.24.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Properties
    @ObservedObject private var viewModel: GroceryViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            title
            listOfProducts()
            Spacer()
            FooterView(viewModel: viewModel)
        }
        .padding()
    }
    
    private var title: some View {
        Text("Grocery Shop")
            .font(.title)
        
    }
    //MARK: - Initializers
    init(viewModel: GroceryViewModel) {
        self.viewModel = viewModel
    }
    
    //MARK: - Methods
    private func listOfProducts() -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                //for all product types
                ForEach(ProductType.allCases) { type in
                    //display type name
                    Text("\(type)")
                        .font(.headline)
                    
                    //display row for that type
                    ForEach(viewModel.productsOf(type: type), id: \.self) { product in
                        ProductRow(viewModel: viewModel, product: product)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(viewModel: GroceryViewModel())
}
