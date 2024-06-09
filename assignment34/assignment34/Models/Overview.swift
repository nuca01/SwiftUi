//
//  Overview.swift
//  assignment34
//
//  Created by nuca on 08.06.24.
//

import Foundation

class Overview: Decodable {
    let overview: String?
    
    init(overview: String?) {
        self.overview = overview
    }
}
