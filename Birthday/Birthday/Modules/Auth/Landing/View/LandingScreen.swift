//
//  LandingScreen.swift
//  Birthday
//
//  Created by Anna Hakobyan on 21.10.24.
//

import SwiftUI

struct LandingScreen: View {
  
  enum Screen: Hashable {
    case signIn
    case registration
    case forgotPassword
    case resetPassword(code: String)
  }

  @StateObject var authRouter = NavigationRouter(.auth)

  private let radiusValue: CGFloat = 42
  
  var body: some View {
    NavigationStack(path: $authRouter.path) {
      ZStack {
        Color.lightPink
          .ignoresSafeArea()
        enterance
          .padding(.horizontal, 68)
      }
      .navigationDestination(for: Screen.self) { screen in
        switch screen {
        case .signIn: SignInScreen(
          viewModel: SignInViewModel(
            signInRepository: SignInDefaultRepository()
          )
        )
        case .registration: RegistrationScreen(
          viewModel: RegistrationViewModel(
            registrationRepository: RegistrationDefaultRepository()
          )
        )
        case .forgotPassword:
          ForgotPasswordScreen(
            viewModel: ForgotPasswordViewModel(
              forgotPasswordRepository: ForgotPasswordDefaultRepository()
            )
          )
        case .resetPassword(let code):
          ResetPasswordScreen(
            viewModel: ResetPasswordViewModel(
              forgotPasswordRepository: ForgotPasswordDefaultRepository(),
              passwordCode: code
            )
          )
        }
      }
    }
    .environmentObject(authRouter)
  }
  
}

extension LandingScreen {
  
  private var enterance: some View {
    VStack(spacing: 0) {
      NavigationBar()
      VStack(spacing: 8) {
        signInButton
        registerButton
      }
      .padding(.vertical, 50)
    }
  }

  private var signInButton: some View {
    LandingButton(
      title: String.Button.signIn,
      textColor: .rouge,
      backgroundColor: .bubblegumPink,
      action: {
        authRouter.push(Screen.signIn)
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
      textColor: .bubblegumPink,
      backgroundColor: .rouge,
      action: {
        authRouter.push(Screen.registration)
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
