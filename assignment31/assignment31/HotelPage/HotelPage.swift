//
//  HotelPage.swift
//  assignment31
//
//  Created by nuca on 30.05.24.
//

import SwiftUI

struct HotelPage: View {
    var hotels: [Hotel]
    
    @Binding var navigationPath: NavigationPath
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List(hotels, id: \.name) { hotel in
            HotelCell(viewModel: HotelCellViewModel(hotel: hotel))
        }
        .listStyle(.insetGrouped)
    }
    
}

#Preview {
    MainScreenView(viewModel: MainScreenViewViewModel())
}
