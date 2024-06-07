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
    
    @State private var showPicker: Bool = false
    
    private let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                CustomSearchBar(searchText: $viewModel.searchQuery)
                
                picker
            }
            moviesGrid
        }
        .background(Color(uiColor: UIColor.secondarySystemBackground))
    }
    
    var picker: some View {
        Menu {
            Picker(selection: $viewModel.selection, label: pickerImage, content: {
                Text("Name").tag("Name")
                Text("Genre").tag("Genre")
                Text("Year").tag("Year")
            })
        } label: {
             pickerImage
        }
        .padding(.trailing)
    }
    
    var pickerImage: some View {
        Image("Picker")
            .resizable()
            .foregroundStyle(Color(uiColor: UIColor.label))
            .frame(width: 30, height: 30)
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
            image(with: movie.posterPath ?? "")
            
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
                .foregroundStyle(Color(uiColor: UIColor(
                    red: 1,
                    green: 0.53,
                    blue: 0,
                    alpha: 1
                )))
            
            infoRow(with: "Ticket", and: Genre(rawValue: movie.genreIds?.first ?? 0)?.name ?? "unavailable")
            
            infoRow(with: "Calendar", and: String(movie.releaseDate?.prefix(4) ?? "unavailable"))
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
                .foregroundColor(Color(uiColor: UIColor.label))
            
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
            .padding(12)
            .padding(.horizontal, 10)
            .background(Color("SearchBarColor", bundle: nil))
            .cornerRadius(18)
            .overlay(
                HStack {
                    Spacer()
                    
                    if isEditing {
                        clearButton
                    } else {
                        magnifyingGlassImage
                    }
                }
            )
            .padding(.horizontal, 10)
            .onTapGesture {
                self.isEditing = true
            }
    }
    
    private var magnifyingGlassImage: some View {
        Image("search")
            .resizable()
            .foregroundColor(Color(uiColor: UIColor.systemGray))
            .frame(width: 20, height: 20)
            .padding(.trailing, 12)
    }
}

#Preview {
    SearchPageView()
}
