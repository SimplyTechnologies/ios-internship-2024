//
//  LandingView.swift
//  Birthday
//
//  Created by Anna Hakobyan on 21.10.24.
//

import SwiftUI

struct LandingView: View {

  var body: some View {
    ZStack {
      Color.lightPink
        .ignoresSafeArea()
      EnteranceView()
        .padding(.horizontal, 67)
    }
  }

}

struct EnteranceView: View {

  var body: some View {
    VStack {
      Image(.birth)
        .imageScale(.large)
      VStack(spacing: 8) {
        LandingButton(
          title: String.Button.signIn,
          textColor: .darkRed,
          backgroundColor: .mainPink,
          action: { print("Navigation to Sign in page") },
          cornerRadii: [42, 0, 42, 42]
        )
        LandingButton(
          title: String.Button.register,
          textColor: .mainPink,
          backgroundColor: .darkRed,
          action: { print("Navigation to Register page") },
          cornerRadii: [42, 42, 42, 0]
        )
      }
      .padding(.vertical, 50)
    }
  }

}
#Preview {
  LandingView()
}
