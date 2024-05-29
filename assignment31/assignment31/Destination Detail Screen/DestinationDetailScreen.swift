//
//  DestinationDetailScreen.swift
//  assignment31
//
//  Created by nuca on 30.05.24.
//

import SwiftUI

struct DestinationDetailScreen: View {
    private var viewModel: DestinationDetailScreenViewModel
    
    var body: some View {
        
        ZStack {
            image
            
            VStack {
                Text(viewModel.destination.name)
                    .font(.largeTitle)
                
                Text(viewModel.destination.information)
                    .font(.callout)
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25))
        }
    }
    
    private var image: some View {
        AsyncImage(url: viewModel.imageURL) { image in
            image
                .image?.resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.5)
        }
    }
    
    init(viewModel: DestinationDetailScreenViewModel) {
        self.viewModel = viewModel
    }
}


#Preview {
    MainScreenView(viewModel: MainScreenViewViewModel())
}
