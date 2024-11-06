//
//  PressedButtonStyle.swift
//  Birthday
//
//  Created by Narek on 05.11.24.
//

import SwiftUI

struct PressedButtonStyle: ButtonStyle {
  
  var cornerRadius: CGFloat = 24
  
  @ViewBuilder
  func makeBody(configuration: Configuration) -> some View {
    let backgroundColor = configuration.isPressed ? Color.gray.opacity(0.1) : Color.white

    configuration.label
      .background(backgroundColor)
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
  }
  
}
