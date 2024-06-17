//
//  ArticlesView.swift
//  assignment 38
//
//  Created by nuca on 16.06.24.
//

import Foundation
import SwiftUI

struct ArticlesView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @StateObject private var viewModel = ArticlesViewModel()
    @State private var isNextViewPresented = false
    @State var selectedRow: NewsItem = NewsItem(id: nil, title: nil, description: nil, url: nil, imageUrl: nil, publishedAt: nil, source: nil)
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                VStack {
                    Text("Articles")
                        .font(.largeTitle)
                        .padding()
                    
                    ArticlesTableView(viewModel: viewModel)
                        .minimumScaleFactor(dynamicTypeSize > DynamicTypeSize.large ? 10 : 0.3)
                        .onAppear {
                            viewModel.fetchArticles()
                        }
                }
                .onChange(of: viewModel.selectedRow?.id) { _, newValue in
                    if newValue != nil {
                        isNextViewPresented = true
                        selectedRow = viewModel.selectedRow!
                    }
                }
                .navigationDestination(isPresented: $isNextViewPresented) {
                    NewsDetailViewControllerRepresentable(newsItem: $selectedRow)
                }
                .onChange(of: isNextViewPresented) { oldValue, newValue in
                    if newValue == false {
                        viewModel.selectedRow = nil
                    }
                }
            }
            
            if viewModel.articles.isEmpty {
                ProgressView()
            }
        }
        
    }
}

#Preview {
    ArticlesView()
}
