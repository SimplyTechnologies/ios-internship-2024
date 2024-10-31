//
//  ResetPasswordScreen.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 30.10.24.
//

import SwiftUI

struct ResetPasswordScreen<T: ResetPasswordViewModeling>: View {
  
  @StateObject var viewModel: T
  
  @EnvironmentObject var router: NavigationRouter
  @EnvironmentObject var appState: AppState
  
  @State var isShowingPassword: Bool = false
  @State var isShowingConfirmPass: Bool = false
  
  var body: some View {
    content
      .background(Color.lightPink)
      .navigationBarBackButtonHidden(true)
      .onChange(of: viewModel.isShowMessage) { isShow in
        appState.isShowMessage = isShow
        if isShow {
          appState.isSuccessMessage = viewModel.isSuccessMessage
          appState.message = viewModel.toastMessage
        }
      }
  }
  
}

extension ResetPasswordScreen {
  
  private var content: some View {
    VStack {
      NavigationBar {
        router.pop()
      }
      VStack(spacing: 24) {
        password
        confirmPassword
        Spacer()
        doneButton
      }
      .padding(.horizontal, 60)
      .padding(.top, 80)
      .padding(.bottom, 30)
    }
  }
  
  private var password: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(String.Auth.newPassword)
        .foregroundStyle(Color.darkRed.opacity(0.7))
        .karmaFont(style: .bold18)
      InputField(
        text: $viewModel.password,
        isFocused: .constant(true),
        isValidField: $viewModel.isPasswordValid,
        isShow: $isShowingPassword,
        isSecureField: true,
        backgroundColor: .white
      )
    }
  }
  
  private var confirmPassword: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(String.Auth.repeatPassword)
        .foregroundStyle(Color.darkRed.opacity(0.7))
        .karmaFont(style: .bold18)
      InputField(
        text: $viewModel.confirmPassword,
        isFocused: .constant(true),
        isValidField: $viewModel.isConfirmPassValid,
        isShow: $isShowingConfirmPass,
        isSecureField: true,
        backgroundColor: .white
      )
    }
  }
  
  private var doneButton: some View {
    RoundedButton(
      name: String.Auth.done,
      isLoading: viewModel.isLoading
    ) {
      viewModel.changePassword(
        navigationAction: {
          router.resetNavigation(
            with: [LandingScreen.Screen.signIn]
          )
        }
      )
    }
  }
  
}

#Preview {
  ResetPasswordScreen(
    viewModel: ResetPasswordViewModel(
      forgotPasswordRepository: ForgotPasswordDefaultRepository(),
      passwordCode: "111111"
    )
  )
}
