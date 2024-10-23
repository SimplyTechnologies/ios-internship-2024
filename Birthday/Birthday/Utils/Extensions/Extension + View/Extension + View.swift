//
//  Untitled.swift
//  Birthday
//
//  Created by Sona on 22.10.24.
//

import SwiftUI

extension View {
  
  func signInCardStyle() -> some View {
    self.background(Color.white)
      .cornerRadius(24)
      .padding(.horizontal, 38)
      .offset(x: 0, y: 0)
  }
  
  func topView() -> some View {
    modifier(CustomNavBarModifier())
  }
  
  func placeholder<Content: View>(
    when shouldShow: Bool,
    alignment: Alignment = .leading,
    @ViewBuilder placeholder: () -> Content
  ) -> some View {
    ZStack(alignment: alignment) {
      placeholder().opacity(shouldShow ? 1 : 0)
      self
    }
  }
  
  func textFieldStyle() -> some View {
    self
      .foregroundColor(.darkRed)
      .padding(.leading, 20)
      .autocorrectionDisabled()
      .frame(height: 41)
  }
  
  func errorTextStyle() -> some View {
    self
      .font(.system(size: 12, design: .default).weight(.regular))
      .foregroundColor(.mainRed)
      .multilineTextAlignment(.leading)
  }
}
