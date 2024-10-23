//
//  FooterModifier.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

struct FooterModifier: ViewModifier {
  
  var title: String
  var isHidden: Bool = false

  func body(content: Content) -> some View {
    if isHidden {
      content
    } else {
      VStack(alignment: .leading, spacing: 0) {
        content
        Spacer().frame(height: 8)

        Text(title)
          .foregroundStyle(Color.red)
          .karmaFont(style: .bold12)
          .multilineTextAlignment(.leading)
          .lineLimit(nil)
          .padding(.horizontal, 4)
      }
    }
  }
  
}
