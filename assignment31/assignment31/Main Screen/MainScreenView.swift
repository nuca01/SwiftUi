//
//  MainScreenView.swift
//  assignment31
//
//  Created by nuca on 29.05.24.
//

import SwiftUI

struct MainScreenView: View {
    @ObservedObject private var viewModel: MainScreenViewViewModel
    @State private var showTip = false
    
    var body: some View {
        NavigationStack {
            title
            tipButton
            listOfDestinations
        }
        .navigationTitle("Travel Destinations")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Travel Tips") {
                    // Show random travel tips using an alert
                    //                        showTravelTip()
                }
            }
        }
        .alert(isPresented: $showTip) {
            Alert(title: Text("Tip!"), message: Text(viewModel.getRandomTip()), dismissButton: .default(Text("Thank you!")))
        }
    }
    
    private var title: some View {
        Text("Travel With Us")
            .font(.largeTitle)
    }
    
    private var listOfDestinations: some View {
        List(viewModel.arrayOfDestinations, id: \.name) { destination in
            NavigationLink(destination: DestinationDetailScreen(viewModel: DestinationDetailScreenViewModel(destination: destination))) {
                VStack {
                    Text(destination.name)
                        .font(.headline)
                    image(for: destination)
                }
            }
        }
        .listStyle(.insetGrouped)
        
    }
    
    private func image(for destination: Destination) -> some View {
        AsyncImage(url: viewModel.imageURL(for: destination)) { image in
            image
                .image?.resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 25))
        }
    }
    
    private var tipButton: some View {
        Button(action: {
            showTip = true
        }) {
            Text("give me a tip")
                .font(.headline)
                .foregroundStyle(Color.brown)
                .padding()
                .background(Color.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 25))
        }
    }
    init(viewModel: MainScreenViewViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    MainScreenView(viewModel: MainScreenViewViewModel())
}
