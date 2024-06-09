//
//  NetworkConfiguring.swift
//  assignment34
//
//  Created by nuca on 09.06.24.
//

import Foundation

struct NetworkConfiguring {
    var queryItems: [URLQueryItem]
    
    let headers: [String: String] = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ODRhNjIxNjY0NjZlZjc1NzYwNzQ5MjgyMmE3MmJkOSIsInN1YiI6IjY2NjBhZDU4ZTg1NjZiNmE4Y2EyMjhlMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7cIzniNLbg7LZB5Z-IjJP7Ftd_dI9F8863UEsREQ0yk"
    ]
    
    init(queryItems: [URLQueryItem]? = nil) {
        self.queryItems = [URLQueryItem(name: "language", value: "en-US")]
        
        if let queryItems {
            self.queryItems += queryItems
        }
    }
}
