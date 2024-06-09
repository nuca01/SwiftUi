//
//  FavouritesPageViewModel.swift
//  assignment34
//
//  Created by nuca on 09.06.24.
//

import Foundation
import SwiftData

class FavouritesPageViewModel: ObservableObject {
    private var modelContext: ModelContext
    
    @Published var movies: [Movie] = []
    
    func fetchFromContext() {
        let fetchDescriptor: FetchDescriptor<Movie> = FetchDescriptor()
        movies = (try? (modelContext.fetch(fetchDescriptor))) ?? []
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchFromContext()
    }
}
