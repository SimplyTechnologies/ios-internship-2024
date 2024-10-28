//
//  SkeletonEffect.swift
//  Birthday
//
//  Created by Narek on 24.10.24.
//

import SwiftUI

struct SkeletonEffect: Animatable, ViewModifier {
  
  @State private var isAnimating: Bool = false
  @Binding var isLoading: Bool

  private let animation: Animation
  private let gradient: Gradient
  private let min = 0.5
  private let max = 1.0
  
  private var startPoint: UnitPoint {
    isAnimating ? UnitPoint(x: 1, y: 1) : UnitPoint(x: min, y: min)
  }

  private var endPoint: UnitPoint {
    isAnimating ? UnitPoint(x: max, y: max) : UnitPoint(x: 0, y: 0)
  }

  init(
    isLoading: Binding<Bool>,
    gradient: Gradient = .init(colors: [.piggyPink, .bubblegumPink, .piggyPink]),
    animation: Animation = Animation.linear(duration: 2).repeatForever(autoreverses: false)
  ) {
    self._isLoading = isLoading
    self.gradient = gradient
    self.animation = animation
  }

  func body(content: Content) -> some View {
    if isLoading {
      content
        .overlay {
          skeletonView
            .mask(content)
        }
    } else {
      content
    }
  }

  private var skeletonView: some View {
    LinearGradient(gradient: self.gradient, startPoint: startPoint, endPoint: endPoint)
      .animation(animation, value: isAnimating)
      .scaleEffect(3)
      .onAppear {
        guard isLoading else { return }
        isAnimating = true
      }
      .onChange(of: isLoading) { _ in
        isAnimating.toggle()
      }
  }
  
}
