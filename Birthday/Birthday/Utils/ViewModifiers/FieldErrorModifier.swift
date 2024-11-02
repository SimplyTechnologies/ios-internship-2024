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
          Spacer()
            .frame(height: 8)
          
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
