//
//  FooterView.swift
//  assignment30
//
//  Created by nuca on 27.05.24.
//

import SwiftUI

struct FooterView: View {
    //MARK: - Properties
    @ObservedObject private var viewModel: GroceryViewModel
    
    var body: some View {
        HStack {
            Text("Items: \(viewModel.totalItems)")
            
            Spacer()
            
            Text("Total: $\(viewModel.totalCost, specifier: "%.2f")")
            
            Spacer()
            
            paymentButton
            
            discountButton
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
    
    private var paymentButton: some View {
        Button(action: {
            if let url = URL(string: "https://www.google.com") {
                UIApplication.shared.open(url)
            }
        }) {
            Text("Payment")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    private var discountButton: some View {
        Button(action: {
            viewModel.toggleDiscount()
        }) {
            Text("Discount")
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    //MARK: - Initializers
    init(viewModel: GroceryViewModel) {
        self.viewModel = viewModel
    }
}
