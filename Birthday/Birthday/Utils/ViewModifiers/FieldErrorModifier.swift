//
//  FieldErrorModifier.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

struct FieldErrorModifier: ViewModifier {
  
  var title: String
  var isHidden: Bool = true

  func body(content: Content) -> some View {
      VStack(alignment: .leading, spacing: 0) {
        content
        if !isHidden {
          Text(title)
            .foregroundStyle(Color.red)
            .karmaFont(style: .bold12)
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .padding(.top, 8)
            .padding(.horizontal, 4)
        }
      }
      .animation(.default, value: isHidden)
  }
  
}
