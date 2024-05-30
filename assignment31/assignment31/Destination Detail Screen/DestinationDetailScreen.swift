//
//  DestinationDetailScreen.swift
//  assignment31
//
//  Created by nuca on 30.05.24.
//

import SwiftUI

struct DestinationDetailScreen: View {
    var viewModel: DestinationDetailScreenViewModel
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        backgroundAndText
        
        buttons
        
    }
    
    
    private var backgroundAndText: some View {
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
    
    private var buttons: some View {
        HStack {
            changeViewButton(imageName: "hotel", view: HotelPage(hotels: viewModel.destination.hotels, navigationPath: $navigationPath))
            
            changeViewButton(imageName: "transport", view: TransportPage(transports: viewModel.destination.transports, navigationPath: $navigationPath))
            
            changeViewButton(imageName: "mustSee", view: MustSeePage(viewModel: MustSeePageViewModel(mustSee: viewModel.destination.mustSee), navigationPath: $navigationPath))
        }
    }
    
    private var image: some View {
        AsyncImage(url: viewModel.imageURL, content:  { image in
            image
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.5)
        }, placeholder: {
            Image("hotel")
                .resizable()
                .scaledToFill()
            .ignoresSafeArea()
            .opacity(0)
        })
    }
    
    private func changeViewButton(imageName: String, view: some View) -> some View {
        NavigationLink(destination: view) {
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
}


#Preview {
    MainScreenView(viewModel: MainScreenViewViewModel())
}
