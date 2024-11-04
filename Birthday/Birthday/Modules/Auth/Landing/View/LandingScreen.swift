//
//  LandingScreen.swift
//  Birthday
//
//  Created by Anna Hakobyan on 21.10.24.
//

import SwiftUI

struct LandingScreen: View {
  
  enum Screen: Hashable {
    
    case signIn(viewModel: SignInViewModel)
    case registration(viewModel: RegistrationViewModel)
    case forgotPassword(viewModel: ForgotPasswordViewModel)
    case resetPassword(viewModel: ResetPasswordViewModel)
    
    var id: UUID {
      switch self {
      case let .signIn(viewModel): viewModel.id
      case let .registration(viewModel): viewModel.id
      case let .forgotPassword(viewModel): viewModel.id
      case let .resetPassword(viewModel): viewModel.id
      }
    }
    
    static func == (lhs: LandingScreen.Screen, rhs: LandingScreen.Screen) -> Bool {
      lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
      switch self {
      case let .signIn(viewModel):
        hasher.combine(viewModel.id)
      case let .registration(viewModel):
        hasher.combine(viewModel.id)
      case let .forgotPassword(viewModel):
        hasher.combine(viewModel.id)
      case let .resetPassword(viewModel):
        hasher.combine(viewModel.id)
      }
    }
    
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
        case let .signIn(viewModel):
          SignInScreen(
            viewModel: viewModel
          )
        case let .registration(viewModel):
          RegistrationScreen(
            viewModel: viewModel
          )
        case let .forgotPassword(viewModel):
          ForgotPasswordScreen(
            viewModel: viewModel
          )
        case let .resetPassword(viewModel):
          ResetPasswordScreen(
            viewModel: viewModel
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
        authRouter.push(
          Screen.signIn(
            viewModel: SignInViewModel(
              signInRepository: SignInDefaultRepository()
            )
          )
        )
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
        authRouter.push(
          Screen.registration(
            viewModel: RegistrationViewModel(
              registrationRepository: RegistrationDefaultRepository()
            )
          )
        )
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
