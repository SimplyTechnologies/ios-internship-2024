//
//  EnabledButton.swift
//  Birthday
//
//  Created by Sona on 22.10.24.
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
        isDisable ? .darkRed : .mainPink
      )
      .font(.system(size: 15, design: .default).weight(.bold))
      .frame(height: 45)
      .frame(maxWidth: .infinity)
      .background(
        isDisable ? .mainPink : .darkRed
      )
      .cornerRadius(25)
      .disabled(isDisable)
  }
  
}
