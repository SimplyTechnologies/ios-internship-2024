//
//  SecondaryRoundedButtonStyle.swift
//  Birthday
//
//  Created by Narek on 30.10.24.
//

import SwiftUI

struct SecondaryRoundedButtonStyle: ButtonStyle {
  
  @Environment(\.isEnabled) var isEnabled
  
  private let isLoading: Bool
  private let backgroundColor: Color
  
  init(_ isLoading: Bool, backgroundColor: Color = .rouge) {
    self.isLoading = isLoading
    self.backgroundColor = backgroundColor
  }

  @ViewBuilder
  func makeBody(configuration: Configuration) -> some View {
    let backgroundColor = backgroundColor.opacity(isEnabled ? 1 : 0.5)
    let pressedColor = Color.rouge.opacity(0.5)
    let background = configuration.isPressed ? pressedColor : backgroundColor
    
    ZStack {
      configuration.label
      if isLoading {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle(tint: .white))
          .controlSize(.regular)
      }
    }
    .foregroundStyle(isLoading ? .clear : .white)
    .karmaFont(style: .bold18)
    .padding(.vertical, 8)
    .padding(.horizontal, 20)
    .background(background)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }
  
}
