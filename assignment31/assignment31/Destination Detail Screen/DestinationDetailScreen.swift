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
        ZStack(alignment: .bottom) {
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
            
            HStack {
                changeViewButton(imageName: "hotel")
                changeViewButton(imageName: "transport")
                changeViewButton(imageName: "mustSee")
            }
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
    
    private func changeViewButton(imageName: String) -> some View {
        Button(action: {

        }) {
            ZStack {
                Circle()
                    .frame(width: 90, height: 90)
                    .foregroundStyle(Color.white)
                    .shadow(radius: 10)
                
                Image(imageName)
                    .resizable()
                    .frame(width: 70, height: 70)
            }
            
        }
    }
    init(viewModel: DestinationDetailScreenViewModel) {
        self.viewModel = viewModel
    }
}


#Preview {
    MainScreenView(viewModel: MainScreenViewViewModel())
}
