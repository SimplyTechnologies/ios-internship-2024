//
//  EnabledButton.swift
//  Birthday
//
//  Created by Sona on 22.10.24.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
  
  @Environment(\.isEnabled) var isEnabled

  @ViewBuilder
  func makeBody(configuration: Configuration) -> some View {
    let backgroundColor = configuration.isPressed ? .mainPink : (isEnabled ? Color.mainPink : Color.darkRed)
    let pressedColor = Color.mainPink
    let background = configuration.isPressed ? pressedColor : backgroundColor
    let tintColor = configuration.isPressed ? .darkRed : (isEnabled ? Color.darkRed : Color.mainPink)

    configuration.label
      .foregroundStyle(tintColor)
      .frame(width: 194, height: 46)
      .background(background)
      .clipShape(Capsule())
  }
  
}
