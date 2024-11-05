//
//  ProfileButton.swift
//  Birthday
//
//  Created by Narek on 29.10.24.
//

import SwiftUI

struct ProfileButton: View {
  
  var title: String
  var action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      HStack(spacing: 0) {
        Text(title)
          .foregroundStyle(.rouge)
          .karmaFont(style: .bold20)
          .padding(.horizontal, 12)
          
        Spacer()
      }
      .padding(.vertical, 10)
      .background(Color.white)
      .clipShape(RoundedRectangle(cornerRadius: 8))
    }
  }
  
}

#Preview {
  ProfileButton(
    title: "Sign Out",
    action: {}
  )
}
