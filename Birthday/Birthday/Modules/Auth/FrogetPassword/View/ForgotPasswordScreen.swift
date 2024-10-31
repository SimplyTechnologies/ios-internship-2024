//
//  ForgotPasswordView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 29.10.24.
//

import SwiftUI

struct ForgotPasswordScreen<T: ForgotPasswordViewModeling>: View {
  
  @StateObject var viewModel: T
  @EnvironmentObject var router: NavigationRouter
  @EnvironmentObject var appState: AppState
  
  var body: some View {
    content
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

extension ForgotPasswordScreen {
  
  private var content: some View {
    VStack {
      NavigationBar {
        router.pop()
      }
      VStack {
        emailField
          .padding(.bottom, 40)
        getCodeButton
        Spacer()
        if !viewModel.actualCode.isEmpty {
          passwordCode
          Spacer()
          setPasswordButton
        }
      }
      .padding(.top, 20)
      .padding(.horizontal, 60)
    }
    .background(Color.lightPink)
  }
  
  private var emailField: some View {
    VStack(alignment: .leading) {
      Text(String.Field.email)
        .foregroundStyle(Color.rouge.opacity(0.7))
        .karmaFont(style: .bold18)
      InputField(
        text: $viewModel.email,
        isFocused: .constant(true),
        isValidField: $viewModel.isEmailValid,
        placeholderText: "example@gmail.com",
        backgroundColor: .white
      )
      .textInputAutocapitalization(.never)
    }
  }
  
  private var getCodeButton: some View {
    RoundedButton(
      name: String.Auth.code,
      isLoading: viewModel.isLoading
    ) {
      viewModel.getCode()
    }
    .disabled(!viewModel.isEmailValid)
    .foregroundStyle(Color.bubblegumPink)
  }
  
  private var passwordCode: some View {
    VStack {
      Text(String.Auth.passwordCode)
        .karmaFont(style: .bold18)
        .foregroundStyle(Color.rouge)
        .padding(.vertical, 10)
      InputField(
        text: $viewModel.passwordCode,
        isFocused: .constant(true),
        isValidField: $viewModel.isCodeValid
      )
      .karmaFont(style: .bold26)
      .keyboardType(.numberPad)
      .frame(width: 120)
      .padding(.horizontal, 70)
      .padding(.bottom, 20)
    }
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 14))
  }
  
  private var setPasswordButton: some View {
    RoundedButton(
      name: String.Auth.setNewPassword
    ) {
      viewModel.checkCode {
        router.push(
          LandingScreen.Screen.resetPassword(
            code: viewModel.passwordCode
          )
        )
      }
    }
    .foregroundStyle(Color.bubblegumPink)
  }
  
}

#Preview {
  ForgotPasswordScreen(
    viewModel:
      ForgotPasswordViewModel(
        forgotPasswordRepository:
          ForgotPasswordDefaultRepository()
      )
  )
}
