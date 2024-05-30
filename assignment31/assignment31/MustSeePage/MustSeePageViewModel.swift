//
//  MustSeePageViewModel.swift
//  assignment31
//
//  Created by nuca on 30.05.24.
//

import Foundation

final class MustSeePageViewModel {
    var mustSee: MustSee
    
    func imageURL() -> URL? {
       URL(string: mustSee.imageURL)
    }
    
    init(mustSee: MustSee) {
        self.mustSee = mustSee
    }
}
