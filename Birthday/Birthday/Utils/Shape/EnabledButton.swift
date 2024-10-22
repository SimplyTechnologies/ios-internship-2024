//
//  EnabledButton.swift
//  Birthday
//
//  Created by Sona on 21.10.24.
//

import SwiftUI

struct EnabledButton: ButtonStyle {
  
  private let isDisable: Bool
  
  init(isDisable: Bool) {
    self.isDisable = isDisable
  }
  
  func makeBody(configuration: Configuration) -> some View {
    configuration
      .label
      .foregroundColor(
        isDisable ? Color.textDark : Color.lightPink
      )
      .font(.system(size: 15, design: .default).weight(.bold))
      .frame(height: 45)
      .frame(maxWidth: .infinity)
      .background(
        isDisable ? Color.lightPink : Color.textDark
      )
      .cornerRadius(25)
      .disabled(isDisable)
  }
  
}
