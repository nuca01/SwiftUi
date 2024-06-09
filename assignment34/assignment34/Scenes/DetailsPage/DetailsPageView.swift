//
//  DetailsPageView.swift
//  assignment34
//
//  Created by nuca on 08.06.24.
//

import SwiftUI
import SwiftData

struct DetailsPageView: View {
    //MARK: - Properties
    @ObservedObject private var viewModel: DetailsPageViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                ZStack(alignment: .topLeading) {
                    ZStack(alignment: .bottomTrailing) {
                        backdropImage
                        
                        stars
                    }
                    
                    posterAndName
                        .padding(EdgeInsets(top: UIScreen.main.bounds.width / 1.78 / 2, leading: 0, bottom: 0, trailing: 0))
                }
                
                info
                
                Spacer()
                    .frame(maxHeight: 40)
                
                about
                
                Spacer()
            }
        }
        .background(Color(uiColor: UIColor.secondarySystemBackground))
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.movie.title ?? "unavailable")
                    .font(.system(size: 30))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .onAppear() {
            viewModel.fetchFromContext()
        }
    }
    
    private var stars: some View {
        infoRow(
            with: "Star",
            and: String(format: "%.1f", viewModel.movie.voteAverage ?? 0),
            isYellow: true
        )
            .padding(EdgeInsets(top: 4, leading: 7, bottom: 4, trailing: 7))
            .background(Color(uiColor: UIColor(red: 37/255, green: 40/255, blue: 54/255, alpha: 0.7)))
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .padding()
    }
    
    private var posterAndName: some View {
        HStack(alignment: .top, spacing: 20) {
            posterImage
            
            VStack {
                Spacer()
                    .frame(height: UIScreen.main.bounds.width / 1.78 / 2)
                
                title
            }
        }
        .padding(30)
    }
    
    private var title: some View {
        Text(viewModel.movie.title ?? "title unavailable")
            .font(.system(size: 30))
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .lineLimit(nil)
    }
    
    private var posterImage: some View {
        image(with: viewModel.movie.posterPath)
            .frame(width: UIScreen.main.bounds.width / 4)
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
    
    private var backdropImage: some View {
        image(with: viewModel.movie.backdropPath)
            .frame(maxWidth: .infinity, minHeight: 100)
            .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
    }
    
    private var info: some View {
        HStack {
            infoRow(with: "Ticket", and: Genre(rawValue: viewModel.movie.genreIds?.first ?? 0)?.name ?? "unavailable")
            
            separator
            
            infoRow(with: "Calendar", and: String(viewModel.movie.releaseDate?.prefix(4) ?? "unavailable"))
        }
    }
    
    private var separator: some View {
        Text(" | ")
            .font(.system(size: 23))
            .foregroundColor(Color(uiColor: UIColor.systemGray))
    }
    
    private var about: some View {
        VStack(alignment: .leading) {
            HStack {
                aboutTitle
                    .padding(4)
                
                Spacer()
                
                favoriteButton
            }
            
            Rectangle()
                .foregroundColor(Color(uiColor: UIColor.systemGray3))
                .frame(height: 4)
            
            Spacer()
                .frame(maxHeight: 20)
            
            aboutText
        }
        .padding()
    }
    
    private var favoriteButton: some View {
        Button(action: {
            viewModel.isFavorite ? viewModel.removeFromFavorites(): viewModel.addToFavorites()
        }) {
            Image(systemName: viewModel.isFavorite ? "heart.fill": "heart")
                .foregroundStyle(Color.red)
        }
    }
    
    private var aboutTitle: some View {
        Text("About Movie")
            .font(.system(size: 20))
    }
    
    private var aboutText: some View {
        Text(viewModel.overview ?? "unavailable")
            .font(.system(size: 18))
            .fontWeight(.light)
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
    }
    
    //MARK: - Methods
    private func image(with url: String?) -> some View {
        AsyncImage(url: viewModel.imageURL(url: url)) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ZStack {
                Image("")
                    .resizable()
                    .border(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .frame(maxHeight: 210)
                
                if url != nil {
                    ProgressView()
                        .fixedSize()
                } else {
                    Image(systemName: "xmark")
                }
            }
        }
    }
    
    private func infoRow(with imageName: String, and text: String, isYellow: Bool = false) -> some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 23, height: 23)
                .foregroundColor(Color(uiColor: UIColor.systemGray))
        
            Text(text)
                .font(.system(size: 17))
                .foregroundStyle(Color(
                    uiColor: isYellow ?
                    UIColor(red: 1, green: 0.53, blue: 0, alpha: 1) : UIColor.systemGray)
                )
        }
    }
    
    //MARK: - Initializer
    init(viewModel: DetailsPageViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Movie.self, configurations: config)

    return DetailsPageView(viewModel: DetailsPageViewModel(
        modelContext: ModelContext(container), 
        movie: Movie(
            posterPath: "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg",
            title: "Venom",
            databaseID: 335983,
            voteAverage: 6.827,
            genreIds: [
        878,
        28
    ], 
            releaseDate: "2018-09-28",
            backdropPath: "/VuukZLgaCrho2Ar8Scl9HtV3yD.jpg"
        )
    ))
        .modelContainer(container)
}
