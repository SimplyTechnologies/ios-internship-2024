//
//  LandingScreen.swift
//  Birthday
//
//  Created by Anna Hakobyan on 21.10.24.
//

import SwiftUI

struct LandingScreen: View {

  private enum Screen: Hashable {
    case signIn
    case registration
  }

  @StateObject var router = NavigationRouter()
  
  private let radiusValue: CGFloat = 42

  var body: some View {
    NavigationStack(path: $router.path) {
      ZStack {
        Color.lightPink
          .ignoresSafeArea()
        enterance
          .padding(.horizontal, 68)
      }
      .navigationDestination(for: Screen.self) { screen in
        switch screen {
        case .signIn: SignInScreen(viewModel: SignInViewModel(router: router))
        case .registration: RegistrationScreen(viewModel: RegistrationViewModel(router: router))
        }
      }
    }
  }

}

extension LandingScreen {

  private var enterance: some View {
    VStack(spacing: 0) {
      logo
      VStack(spacing: 8) {
        signInButton
        registerButton
      }
      .padding(.vertical, 50)
    }
  }

  private var logo: some View {
    Image(.birth)
      .imageScale(.large)
  }

  private var signInButton: some View {
    LandingButton(
      title: String.Button.signIn,
      textColor: .rouge,
      backgroundColor: .mainPink,
      action: {
        router.push(Screen.signIn)
      },
      cornerRadius: [
        radiusValue,
        0,
        radiusValue,
        radiusValue
      ]
    )
  }

  private var registerButton: some View {
    LandingButton(
      title: String.Button.register,
      textColor: .mainPink,
      backgroundColor: .rouge,
      action: {
        router.push(Screen.registration)
      },
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
  LandingScreen()
}
