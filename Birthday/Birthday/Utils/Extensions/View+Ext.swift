//
//  View+Ext.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

extension View {
  
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

  func dismissKeyboard() -> some View {
    return modifier(ResignKeyboardOnDragModifier())
  }

  func disableBounces() -> some View {
    modifier(DisableBouncesModifier())
  }
  
}
