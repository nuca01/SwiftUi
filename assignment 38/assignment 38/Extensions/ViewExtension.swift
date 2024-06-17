//
//  ViewExtension.swift
//  assignment 38
//
//  Created by nuca on 17.06.24.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func scaledFont(name: String = UIFont.systemFont(ofSize: 0).familyName, size: CGFloat, weight: Font.Weight = .regular) -> some View {
      if #available(iOS 16.0, *) {
         self
              .font(.custom(name, size: size, relativeTo: .body))
              .fontWeight(weight)
      } else {
         self
          .font(
            .custom(name, size: size, relativeTo: .body)
            .weight(weight)
          )
      }
    }
}
