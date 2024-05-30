//
//  MustSeePage.swift
//  assignment31
//
//  Created by nuca on 30.05.24.
//

import SwiftUI

struct MustSeePage: View {
    var viewModel: MustSeePageViewModel
    
    var body: some View {
        ZStack {
            image
        }
        VStack {
            name
            information
        }
        
    }
    
    private var name: some View {
        Text(viewModel.mustSee.name)
            .font(.title)
    }
    
    private var information: some View {
        Text(viewModel.mustSee.information)
            .multilineTextAlignment(.leading)
            .lineLimit(4)
            .font(.body)
            .fontWeight(.bold)
            .frame(maxWidth: UIScreen.main.bounds.size.width - 20)
    }
    
    private var image: some View {
        AsyncImage(url: viewModel.imageURL(), content:  { image in
            image
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.8)
        }, placeholder: {
            Image("hotel")
            .opacity(0)
        })
    }
    
}

#Preview {
    MainScreenView(viewModel: MainScreenViewViewModel())
}
