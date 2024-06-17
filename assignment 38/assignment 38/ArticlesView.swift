//
//  ArticlesView.swift
//  assignment 38
//
//  Created by nuca on 16.06.24.
//

import Foundation

import SwiftUI
import UIKit

struct ArticlesView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @StateObject private var viewModel = ArticlesViewModel()
    @State private var isNextViewPresented = false
    
    var body: some View {
        NavigationStack {
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
            .onChange(of: viewModel.selectedRow?.id) { _, _ in
                isNextViewPresented = true
            }
            .navigationDestination(isPresented: $isNextViewPresented) {
                if isNextViewPresented {
                    NewsDetailViewControllerRepresentable(newsItem: viewModel.selectedRow!)
                }
            }
        }
    }
}

#Preview {
    ArticlesView()
}

struct ArticlesTableView: UIViewRepresentable {
    @ObservedObject var viewModel: ArticlesViewModel
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView()
        tableView.delegate = context.coordinator
        tableView.dataSource = context.coordinator
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
        uiView.reloadData()
    }
    
    class Coordinator: NSObject, UITableViewDelegate, UITableViewDataSource {
        var parent: ArticlesTableView
        
        init(_ parent: ArticlesTableView) {
            self.parent = parent
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            parent.viewModel.articles.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
            let newsItem = parent.$viewModel.articles[indexPath.row]
            cell.configure(with: newsItem)
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            parent.viewModel.selectedRow = parent.viewModel.articles[indexPath.row]
        }
    }
}
