//
//  Results.swift
//  assignment34
//
//  Created by nuca on 06.06.24.
//

import Foundation

class Results: Decodable {
    let results: [Movie]
    
    init(results: [Movie]) {
        self.results = results
    }
}
