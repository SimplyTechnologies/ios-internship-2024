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
  
}

extension View {
  
  func onLoad(perform action: (() -> Void)? = nil) -> some View {
    modifier(ViewDidLoadModifier(perform: action))
  }
  
  @ViewBuilder func isLoading(_ flag: Bool) -> some View {
    self.overlay {
      if flag {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle(tint: .lightPink))
          .controlSize(.large)
      }
    }
  }
  
}

extension View {
  
  func skeletonEffect(
    isLoading: Binding<Bool>,
    gradient: Gradient = .init(colors: [.piggyPink, .bubblegumPink, .piggyPink]),
    animation: Animation = Animation.linear(duration: 2).repeatForever(autoreverses: false)
  ) -> some View {
    modifier(
      SkeletonEffect(
        isLoading: isLoading,
        gradient: gradient,
        animation: animation
      )
    )
  }
  
}

extension View {
  
  func customAlert(isPresented: Binding<Bool>) -> some View {
    self.modifier(AlertModifier(isPresented: isPresented))
  }
  
}

extension View {
  
  func onShake(perform action: @escaping () -> Void) -> some View {
    self.modifier(DeviceShakeViewModifier(action: action))
  }
  
}

extension View {
  
  func loadingOverlay(isLoading: Binding<Bool>) -> some View {
    self.modifier(LoadingOverlayModifier(isLoading: isLoading))
  }
  
}

extension View {
  
  @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
    if condition() {
      transform(self)
    } else {
      self
    }
  }
  
}
