//
//  MainScreenView.swift
//  assignment31
//
//  Created by nuca on 29.05.24.
//

import SwiftUI

struct MainScreenView: View {
   @ObservedObject private var viewModel: MainScreenViewViewModel
    
    var body: some View {
        NavigationStack {
            title
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
    
    init(viewModel: MainScreenViewViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    MainScreenView(viewModel: MainScreenViewViewModel())
}
