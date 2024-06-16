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
    
    var body: some View {
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
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
            let article = parent.viewModel.articles[indexPath.row]
            cell.configure(with: article)
            return cell
        }
    }
}
