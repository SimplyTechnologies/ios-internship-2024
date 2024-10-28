//
//  DisableBouncesModifier.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

struct DisableBouncesModifier: ViewModifier {
  
  func body(content: Content) -> some View {
    content
      .onAppear {
        UIScrollView.appearance().bounces = false
      }
      .onDisappear {
        UIScrollView.appearance().bounces = true
      }
  }
  
}
