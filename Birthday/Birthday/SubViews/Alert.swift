//
//  Alert.swift
//  Birthday
//
//  Created by Anna Hakobyan on 01.11.24.
//

import SwiftUI

struct AlertView: View {
  
  var title: String
  var message: String
  var confirmAction: () -> Void
  var cancelAction: () -> Void
  
  init(title: String, message: String, confirmAction: @escaping () -> Void, cancelAction: @escaping () -> Void) {
    self.title = title
    self.message = message
    self.confirmAction = confirmAction
    self.cancelAction = cancelAction
  }
  
  var body: some View {
    VStack(
      alignment: .center,
      spacing: 10
    ) {
      Image(systemName: "rectangle.portrait.and.arrow.right")
        .foregroundStyle(.rouge)
        .font(.system(size: 30))
      VStack {
        Text(title)
          .karmaFont(style: .bold22)
          .foregroundColor(.rouge)
        
        Text(message)
          .karmaFont(style: .bold16)
          .foregroundColor(.rouge)
          .multilineTextAlignment(.center)
      }
      HStack(spacing: 30) {
        RoundedButton(
          name: String.Button.cancel,
          isSecondary: true,
          action: cancelAction
        )
        RoundedButton(
          name: String.Button.signOut,
          isSecondary: true,
          action: confirmAction
        )
      }
      .padding(.horizontal, 10)
    }
    
    .frame(width: 350, height: 200)
    .background(Color.lightPink)
    .cornerRadius(12)
    .overlay(
      RoundedRectangle(cornerRadius: 12)
        .stroke(Color.rouge, lineWidth: 2)
    )
  }
  
}

#Preview {
  AlertView(title: String.Button.signOut, message: "Are you sure ?", confirmAction: {print("Amma")}, cancelAction: {
    print("dsf")
  })
}
