//
//  HotelCellViewModel.swift
//  assignment31
//
//  Created by nuca on 30.05.24.
//

import Foundation

final class HotelCellViewModel {
    var hotel: Hotel
    
    func imageURL() -> URL? {
       URL(string: hotel.imageURL)
    }
    
    init(hotel: Hotel) {
        self.hotel = hotel
    }
}
