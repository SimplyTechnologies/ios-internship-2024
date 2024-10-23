//
//  RoundedButtonStyle.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
  
  let isEnabled: Bool

  init(_ isEnabled: Bool) {
    self.isEnabled = isEnabled
  }

  @ViewBuilder
  func makeBody(configuration: Configuration) -> some View {
    let backgroundColor = Color.bubblegumPink.opacity(isEnabled ? 1 : 0.5)
    let pressedColor = Color.rouge
    let background = configuration.isPressed ? pressedColor : backgroundColor
    let tintColor = configuration.isPressed ? Color.bubblegumPink : Color.rouge

    configuration.label
      .foregroundStyle(tintColor)
      .karmaFont(style: .bold16)
      .frame(width: 194, height: 46)
      .background(background)
      .clipShape(Capsule())
  }
  
}
