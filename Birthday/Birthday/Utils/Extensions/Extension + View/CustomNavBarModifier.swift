//
//  CustomNavBarModifier.swift
//  Birthday
//
//  Created by Sona on 22.10.24.
//

import SwiftUI

struct CustomNavBarModifier: ViewModifier {
  
  @Environment(\.presentationMode) var presentationMode

  func body(content: Content) -> some View {
    ZStack {
        Color.lightPink.ignoresSafeArea()
      VStack {
        HStack {
          Button {
            presentationMode.wrappedValue.dismiss()
          } label: {
              Image(.back)
          }
          Spacer()
            Image(.icon)
        } .padding(.horizontal, 24)
        content
      }
    }
    .navigationBarHidden(true)
  }
  
}
