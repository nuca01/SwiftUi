//
//  ExtendedMovieCell.swift
//  assignment34
//
//  Created by nuca on 09.06.24.
//

import SwiftUI

struct ExtendedMovieCell: View {
    //MARK: - Properties
    private let movie: Movie
    
    private let url: URL?
    
    var body: some View {
        HStack(alignment: .top) {
            image
            
            info
            
            Spacer()
        }
    }
    
    private var info: some View {
        VStack(alignment: .leading) {
            Text(movie.title ?? "title unavailable")
                .font(.system(size: 21))
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .padding(EdgeInsets(
                    top: 7,
                    leading: 0,
                    bottom: 0,
                    trailing: 0
                ))
            
            Spacer()
            
            infoRow(with: "Star", and: String(format: "%.1f", movie.voteAverage ?? 0))
            
            infoRow(with: "Ticket", and: Genre(rawValue: movie.genreIds?.first ?? 0)?.name ?? "unavailable")
            
            infoRow(with: "Calendar", and: String(movie.releaseDate?.prefix(4) ?? "unavailable"))
        }
    }
    
    @ViewBuilder
    private var image: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 120)
                .clipShape(RoundedRectangle(cornerRadius: 25))
        } placeholder: {
            VStack() {
                Spacer()
                
                if url != nil {
                    ProgressView()
                        .fixedSize()
                } else {
                    Image(systemName: "xmark")
                }
                
                Spacer()
            }
            .frame(maxWidth: 120)
        }
    }
    
    //MARK: - Method
    private func infoRow(with imageName: String, and text: String) -> some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 23, height: 23)
                .foregroundColor(Color(uiColor: UIColor.label))
            
            Text(text)
                .font(.system(size: 17))
            
        }
    }
    
    //MARK: - Initializer
    init(movie: Movie, url: URL?) {
        self.movie = movie
        self.url = url
    }
}
