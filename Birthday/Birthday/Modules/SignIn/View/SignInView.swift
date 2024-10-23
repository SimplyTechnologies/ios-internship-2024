//
//  SignInView.swift
//  Birthday
//
//  Created by Sona on 22.10.24.
//

import SwiftUI

struct SignInView: View {
  
  @StateObject private var viewModel = SignInViewModel()
  @State private var isPasswordHide: Bool = true
  
  var body: some View {
    ZStack {
      Color.lightPink
        .ignoresSafeArea()
      VStack(spacing: 0) {
        Spacer()
        VStack(spacing: 20.0) {
          SignInHeader()
          signInFields
          SignInButton(isEnabled: viewModel.buttonDisabledState) {
            // TODO: Handle sign in action
          }
        }
        .signInCardStyle()
        Spacer()
      }
      .topView()
    }
  }
  
  private var signInFields: some View {
    VStack(spacing: 15.0) {
      VStack(spacing: 20) {
        ValidationTextField(placeholder: String.TextField.email,
                            inputText: $viewModel.email,
                            errorText: viewModel.emailErrorText,
                            isPasswordHidden: .constant(false),
                            isSecure: false)
          .onChange(of: viewModel.email) { _ in
            viewModel.checkEmail()
          }
        ValidationTextField(placeholder: String.TextField.password,
                            inputText: $viewModel.password,
                            errorText: viewModel.passErrorText,
                            isPasswordHidden: $isPasswordHide,
                            isSecure: true)
          .onChange(of: viewModel.password) { _ in
            viewModel.checkPassword()
          }
      }
      .padding(.horizontal, 23)
    }
  }
}

private struct SignInHeader: View {
  var body: some View {
    Text(String.Button.login)
      .font(.system(size: 20, design: .default).weight(.bold))
      .foregroundColor(.darkRed)
      .padding(.top, 20)
  }
}

private struct SignInButton: View {
  let isEnabled: Bool
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text(String.Button.login)
    }
    .buttonStyle(PrimaryButtonStyle(isDisable: !isEnabled))
    .padding(.horizontal, 62)
    .padding(.bottom, 50)
    .padding(.top, 30)
    .disabled(!isEnabled)
  }
}

#Preview {
  SignInView()
}
