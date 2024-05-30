//
//  HotelCell.swift
//  assignment31
//
//  Created by nuca on 30.05.24.
//

import SwiftUI

struct HotelCell: View {
    var viewModel: HotelCellViewModel
    var body: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .center) {
                name
                stars
                image
                information
            }
            
            Spacer()
        }
    }
    
    private var name: some View {
        Text(viewModel.hotel.name)
            .font(.headline)
    }
    
    private var stars: some View {
        HStack {
            ForEach(0..<viewModel.hotel.stars, id: \.self) { _ in
                Image(systemName: "star")
            }
        }
    }
    
    private var image: some View {
        AsyncImage(url: viewModel.imageURL(), content:  { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
        }, placeholder: {
            Image("hotel")
                .frame(width: 200, height: 200)
            .opacity(0)
        })
        .padding()
    }
    
    private var information: some View {
        Text(viewModel.hotel.information)
            .font(.body)
    }
}
