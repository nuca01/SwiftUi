//
//  assignment31App.swift
//  assignment31
//
//  Created by nuca on 29.05.24.
//

import SwiftUI

@main
struct assignment31App: App {
    var body: some Scene {
        WindowGroup {
            MainScreenView(viewModel: MainScreenViewViewModel())
        }
    }
}
