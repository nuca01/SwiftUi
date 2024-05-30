//
//  TransportPage.swift
//  assignment31
//
//  Created by nuca on 30.05.24.
//

import SwiftUI

struct TransportPage: View {
    var transports: Transports
    @Binding var navigationPath: NavigationPath
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        transportView(with: transports.bus, and: "bus")
        
        transportView(with: transports.subway, and: "subway")
        
        transportView(with: transports.taxi, and: "taxi")
        
        transportView(with: transports.tram, and: "tram")
        
        button
    }
    
    private var button: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Button")
        })
    }
    
    func transportView(with transport: Transport, and imageName: String) -> some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .padding()
            
            Text(transport.information ?? (transport.available ? "no information available" : "not available in the city"))
            
            Spacer()
            
            if transport.available {
                Image(systemName: "checkmark")
                    .foregroundStyle(Color.green)
                    .padding()
            } else {
                Image(systemName: "xmark")
                    .foregroundStyle(Color.red)
                    .padding()
            }
        }
        .background(Color.black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .padding()
    }
}

#Preview {
    MainScreenView(viewModel: MainScreenViewViewModel())
}
