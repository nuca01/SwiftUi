//
//  SearchPageView.swift
//  assignment34
//
//  Created by nuca on 06.06.24.
//

import SwiftUI

struct SearchPageView: View {
    //MARK: - Properties
    @StateObject var viewModel = SearchPageViewModel()
    
    private let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
//        NavigationStack {
            CustomSearchBar(searchText: $viewModel.searchQuery)
                .background(Color.pink.opacity(0.2))
                moviesGrid
                .background(Color.pink.opacity(0.2))
//        }
//        .searchable(text: $viewModel.searchQuery, placement: .automatic, prompt: "search for a movie")
//        .onChange(of: viewModel.searchQuery) {
//            viewModel.fetchData()
//        }
    }
    
    var moviesGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: 30) {
                if let movies = viewModel.results {
                    ForEach(movies) { movie in
                        ExtendedMovieCell(movie: movie)
                    }
                }
            }
            .padding()
        }
    }
}

//MARK: - MovieCell
struct ExtendedMovieCell: View {
    private let movie: Movie
    
    var body: some View {
        HStack(alignment: .top) {
            image(with: movie.posterPath)
            
            info
            
            Spacer()
        }
    }
    
    private var info: some View {
        VStack(alignment: .leading) {
            Text(movie.title)
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
            
            infoRow(with: "Star", and: String(format: "%.1f", movie.voteAverage))
                .foregroundStyle(Color(uiColor: UIColor(
                    red: 1,
                    green: 0.53,
                    blue: 0,
                    alpha: 1
                )))
            
            infoRow(with: "Ticket", and: Genre(rawValue: movie.genreIds[0])?.name ?? "unavailable")
            
            infoRow(with: "Calendar", and: String(movie.releaseDate.prefix(4)))
        }
    }
    
    private func image(with url: String) -> some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(url)")) { image in
            image
                 .resizable()
                 .scaledToFit()
                 .frame(maxWidth: 120)
                 .clipShape(RoundedRectangle(cornerRadius: 25))
         } placeholder: {
             ProgressView()
                 .fixedSize()
         }
     }
    
    private func infoRow(with imageName: String, and text: String) -> some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 23, height: 23)
            
            Text(text)
                .font(.system(size: 17))
            
        }
    }

     init(movie: Movie) {
         self.movie = movie
     }
 }

struct CustomSearchBar: View {
    @Binding var searchText: String
    @State private var isEditing = false

    var body: some View {
        HStack {
            textfield

            if isEditing {
                cancelButton
            }
        }
    }
    
    private var cancelButton: some View {
        Button(action: {
            self.isEditing = false
            self.searchText = ""
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }) {
            Text("Cancel")
        }
        .padding(.trailing, 10)
        .transition(.move(edge: .trailing))
    }
    
    private var clearButton: some View {
        Button(action: {
            self.searchText = ""
        }) {
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.gray)
                .padding(.trailing, 8)
        }
    }
    
    private var textfield: some View {
        TextField("Search...", text: $searchText)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                HStack {
                    magnifyingGlassImage

                    if isEditing {
                        clearButton
                    }
                }
            )
            .padding(.horizontal, 10)
            .onTapGesture {
                self.isEditing = true
            }
    }
    
    private var magnifyingGlassImage: some View {
        Image(systemName: "magnifyingglass")
            .foregroundColor(.gray)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 8)
    }
}

#Preview {
    SearchPageView()
}
