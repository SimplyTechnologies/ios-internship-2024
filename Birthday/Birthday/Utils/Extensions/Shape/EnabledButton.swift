//
//  EnabledButton.swift
//  Birthday
//
//  Created by Sona on 22.10.24.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
  
  let isDisable: Bool
  
  func makeBody(configuration: Configuration) -> some View {
    configuration
      .label
      .foregroundColor(configuration.isPressed ? .darkRed : (isDisable ? .mainPink : .darkRed))
      .font(.system(size: 15, design: .default).weight(.bold))
      .frame(height: 45)
      .frame(maxWidth: .infinity)
      .background(configuration.isPressed ? .mainPink : (isDisable ? .darkRed : .mainPink))
      .cornerRadius(25)
      .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
      .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
  }
  
}
