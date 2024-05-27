//
//  assignment30App.swift
//  assignment30
//
//  Created by nuca on 27.05.24.
//

import SwiftUI

@main
struct assignment30App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: GroceryViewModel())
        }
    }
}
