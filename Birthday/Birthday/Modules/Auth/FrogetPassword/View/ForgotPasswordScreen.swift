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
      .onLoad {
        viewModel.isShowMessageChanged { isShow in
          appState.isShowMessage = isShow
          if isShow {
            appState.isSuccessMessage = viewModel.isSuccessMessage
            appState.message = viewModel.toastMessage
          }
        }
      }
      .navigationBarBackButtonHidden(true)
  }
  
}

extension ForgotPasswordScreen {
  
  private var content: some View {
    VStack {
      NavigationBar {
        router.pop()
      }
      GeometryReader { geo in
        ScrollView {
          VStack {
            emailField
              .padding(.bottom, 40)
            getCodeButton
            Spacer()
            if !viewModel.actualCode.isEmpty {
              passwordCode
              Spacer()
              setPasswordButton
                .padding(.bottom, 40)
            }
          }
          .padding(.top, 20)
          .padding(.horizontal, 60)
          .frame(
            maxWidth: .infinity,
            minHeight: geo.size.height,
            alignment: .bottom
          )
        }
        .scrollIndicators(.hidden)
      }
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
        isFocused: $viewModel.isEmailFocused,
        isValidField: $viewModel.isEmailValid,
        placeholderText: "example@gmail.com",
        backgroundColor: .white
      )
      .keyboardType(.emailAddress)
      .modifier(
        FieldErrorModifier(
          title: viewModel.emailErrorMessage,
          isHidden: viewModel.isEmailValid
        )
      )
    }
  }
  
  private var getCodeButton: some View {
    RoundedButton(
      name: String.Auth.code,
      isLoading: viewModel.isLoading
    ) {
      UIApplication.shared.hideKeyboard()
      viewModel.getCode()
    }
    .disabled(viewModel.isGetCodeDisabled)
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
        isFocused: $viewModel.isCodeFocused,
        isValidField: $viewModel.isCodeValid
      )
      .karmaFont(style: .bold26)
      .keyboardType(.numberPad)
      .modifier(
        FieldErrorModifier(
          title: viewModel.codeErrorMessage,
          isHidden: viewModel.isCodeValid
        )
      )
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
      UIApplication.shared.hideKeyboard()
      viewModel.checkCode {
        router.push(
          LandingScreen.Screen.resetPassword(
            viewModel: ResetPasswordViewModel(
              forgotPasswordRepository: ForgotPasswordDefaultRepository(),
              passwordCode: viewModel.passwordCode
            )
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
