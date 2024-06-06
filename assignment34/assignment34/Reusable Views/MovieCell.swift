//
//  MovieCell.swift
//  assignment34
//
//  Created by nuca on 06.06.24.
//

import SwiftUI

struct MovieCell: View {
    //MARK: - Properties
    private let movie: Movie
    
    var body: some View {
        VStack(alignment: .center) {
            image(with: movie.posterPath)
            
            Text(movie.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
            
            Spacer()
        }
    }
    
    //MARK: - Method
    private func image(with url: String) -> some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(url)")) { image in
            image
                 .resizable()
                 .scaledToFit()
                 .clipShape(RoundedRectangle(cornerRadius: 25))
         } placeholder: {
             ProgressView()
                 .fixedSize()
         }
     }

    //MARK: - Initializer
     init(movie: Movie) {
         self.movie = movie
     }
 }
