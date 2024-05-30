//
//  MainScreenView.swift
//  assignment31
//
//  Created by nuca on 29.05.24.
//

import SwiftUI

struct MainScreenView: View {
    //MARK: - Properties
    @ObservedObject private var viewModel: MainScreenViewViewModel
    
    @State private var showTip = false
    
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            title
            listOfDestinations
            tipButton
        }
        .navigationTitle("Travel Destinations")
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
            NavigationLink(destination: DestinationDetailScreen(viewModel: DestinationDetailScreenViewModel(destination: destination), navigationPath: $navigationPath)) {
                VStack {
                    Text(destination.name)
                        .font(.headline)
                    image(for: destination)
                }
            }
        }
        .listStyle(.insetGrouped)
        
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
                .shadow(radius: 5)
        }
    }
    
    //MARK: - Method
    
    private func image(for destination: Destination) -> some View {
        AsyncImage(url: viewModel.imageURL(for: destination)) { image in
            image
                .image?.resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 25))
        }
    }
    
    //MARK: - Initializer
    
    init(viewModel: MainScreenViewViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    MainScreenView(viewModel: MainScreenViewViewModel())
}
