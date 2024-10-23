//
//  LandingView.swift
//  Birthday
//
//  Created by Anna Hakobyan on 21.10.24.
//

import SwiftUI

struct LandingView: View {

  private let radiusValue: CGFloat = 42 //Corner Radius value for the buttons

  var body: some View {
    ZStack {
      Color.lightPink
        .ignoresSafeArea()
      enterance
        .padding(.horizontal, 67)
    }
  }

}

extension LandingView {

  private var enterance: some View {
    VStack {
      logo
      VStack(spacing: 8) {
        login
        register
      }
      .padding(.vertical, 50)
    }
  }

  private var logo: some View {
    Image(.birth)
      .imageScale(.large)
  }

  private var login: some View {
    LandingButton(
      title: String.Button.signIn,
      textColor: .darkRed,
      backgroundColor: .mainPink,
      action: { print("Navigation to Sign in page") },
      cornerRadius: [
        radiusValue,
        0,
        radiusValue,
        radiusValue
      ]
    )
  }

  private var register: some View {
    LandingButton(
      title: String.Button.register,
      textColor: .mainPink,
      backgroundColor: .darkRed,
      action: { print("Navigation to Register page") },
      cornerRadius: [
        radiusValue,
        radiusValue,
        radiusValue,
        0
      ]
    )
  }

}

#Preview {
  LandingView()
}
