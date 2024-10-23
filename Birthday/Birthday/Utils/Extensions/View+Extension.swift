//
//  View+Extension.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import Foundation
import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
  
  @State private var didLoad = false
  private let action: (() -> Void)?
  
  init(perform action: (() -> Void)? = nil) {
    self.action = action
  }
  
  func body(content: Content) -> some View {
    content.onAppear {
      if didLoad == false {
        didLoad = true
        action?()
      }
    }
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
