//
//  AlertModifier.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 25.10.24.
//

import SwiftUI

struct AlertModifier: ViewModifier {
  
  @Binding var isPresented: Bool
  
  func body(content: Content) -> some View {
    ZStack {
      content
        .blur(radius: isPresented ? 20.0 : 0.0)
      if isPresented {
        Color.black.opacity(0.001)
          .edgesIgnoringSafeArea(.all)
          .onTapGesture {
            withAnimation {
              isPresented = false
            }
          }
        GenerateMessageView(
          isPresented: $isPresented
        )
      }
    }
    .animation(.easeInOut, value: isPresented)
  }
  
}
