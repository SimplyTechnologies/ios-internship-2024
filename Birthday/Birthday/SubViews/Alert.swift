//
//  Alert.swift
//  Birthday
//
//  Created by Anna Hakobyan on 01.11.24.
//

import SwiftUI

struct AlertView: View {
  
  @State private var isVisible: Bool = false
  
  private let animationDuration: Double
  private let title: String
  private let message: String
  private let confirmButtonTitle: String
  private let confirmAction: () -> Void
  private let cancelAction: () -> Void
  
  init(title: String, message: String, confirmButtonTitle: String, confirmAction: @escaping () -> Void, cancelAction: @escaping () -> Void) {
    self.animationDuration = 0.3
    self.title = title
    self.message = message
    self.confirmButtonTitle = confirmButtonTitle
    self.confirmAction = confirmAction
    self.cancelAction = cancelAction
  }
  
  var body: some View {
    ZStack {
      Color.black.opacity(0.5)
        .ignoresSafeArea()
        .onTapGesture {
          isVisible = false
          DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            cancelAction()
          }
        }
      
      VStack(spacing: 10) {
        icon
        infoView
        buttons
      }
      .padding(24)
      .background(Color.lightPink)
      .clipShape(RoundedRectangle(cornerRadius: 12))
      .overlay(
        RoundedRectangle(cornerRadius: 12)
          .stroke(Color.rouge, lineWidth: 2)
      )
      .padding(24)
      .scaleEffect(isVisible ? 1 : 0)
      .animation(.easeInOut(duration: animationDuration), value: isVisible)
      .onAppear {
        isVisible = true
      }
    }
  }
  
  private var icon: some View {
    Image(systemName: "rectangle.portrait.and.arrow.right")
      .foregroundStyle(.rouge)
      .font(.system(size: 30))
  }
  
  private var infoView: some View {
    VStack(spacing: 10) {
      Text(title)
        .karmaFont(style: .bold22)
        .foregroundColor(.rouge)
      
      Text(message)
        .karmaFont(style: .bold16)
        .foregroundColor(.rouge)
        .multilineTextAlignment(.center)
    }
  }
  
  private var buttons: some View {
    HStack(spacing: 30) {
      cancelButton
      confirmButton
    }
    .padding(.horizontal, 10)
  }
  
  private var cancelButton: some View {
    RoundedButton(
      name: String.Button.cancel,
      isSecondary: true,
      backgroundColor: Color.bubblegumPink,
      action: {
        isVisible = false
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
          cancelAction()
        }
      }
    )
  }
  
  private var confirmButton: some View {
    RoundedButton(
      name: confirmButtonTitle,
      isSecondary: true,
      action: {
        isVisible = false
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
          confirmAction()
        }
      }
    )
  }
  
}

#Preview {
  AlertView(title: "Anna", message: "lalala", confirmButtonTitle: "lav", confirmAction: {}, cancelAction: {})
}
