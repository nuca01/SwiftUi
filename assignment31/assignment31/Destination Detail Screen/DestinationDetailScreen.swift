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
            
            NavigationLink(value: viewModel.destination.hotels) {
                changeViewButton(imageName: "hotel")
            }
            .navigationDestination(for: [Hotel].self) { hotels in
                HotelPage(hotels: hotels)
            }
            
            NavigationLink(value: viewModel.destination.transports) {
                changeViewButton(imageName: "transport")
            }
            .navigationDestination(for: Transports.self) { transports in
                TransportPage(transports: transports, navigationPath: $navigationPath)
            }
            
            NavigationLink(value: viewModel.destination.mustSee) {
                changeViewButton(imageName: "mustSee")
            }
            .navigationDestination(for: MustSee.self) { mustSee in
                MustSeePage(viewModel: MustSeePageViewModel(mustSee: mustSee))
            }
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
    
    private func changeViewButton(imageName: String) -> some View {
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


#Preview {
    MainScreenView(viewModel: MainScreenViewViewModel())
}
