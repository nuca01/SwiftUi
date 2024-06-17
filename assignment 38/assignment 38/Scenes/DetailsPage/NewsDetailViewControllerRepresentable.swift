//
//  NewsDetailViewControllerRepresentable.swift
//  assignment 38
//
//  Created by nuca on 17.06.24.
//

import Foundation
import SwiftUI

struct NewsDetailViewControllerRepresentable: UIViewControllerRepresentable {
    @Binding var newsItem: NewsItem
    
    func makeUIViewController(context: Context) -> NewsDetailViewController {
        let viewController = NewsDetailViewController()
        viewController.newsItem = newsItem
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: NewsDetailViewController, context: Context) {
        uiViewController.newsItem = newsItem
        uiViewController.viewDidLoad()
    }
}
