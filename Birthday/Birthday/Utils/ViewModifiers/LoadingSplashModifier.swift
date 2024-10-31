//
//  LoadingSplashModifier.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 31.10.24.
//

import SwiftUI

struct LoadingOverlayModifier: ViewModifier {
  
  @Binding var isLoading: Bool
  
  func body(content: Content) -> some View {
    ZStack {
      content
      if isLoading {
        Color.black.opacity(0.5)
          .ignoresSafeArea()
        ProgressView()
          .progressViewStyle(.circular)
          .scaleEffect(1.5)
      }
    }
  }
  
}
