//
//  SignInScreen.swift
//  Birthday
//
//  Created by Sona on 22.10.24.
//

import SwiftUI

struct SignInScreen: View {
  
  private enum Field: Int, CaseIterable {
    case email, password
  }
  
  @StateObject var viewModel: SignInViewModel
  @FocusState private var focusedField: Field?
  
  var body: some View {
    content
  }
  
}
  
extension SignInScreen {
  private var content: some View {
    ZStack {
      Color.lightPink
        .ignoresSafeArea()
      VStack(spacing: 0) {
        NavigationBar {
          viewModel.router.pop()
        }
        Spacer()
        signInForm
        Spacer()
      }
    }
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .keyboard) {
        keyboardButtons
      }
    }
  }
  
  private var keyboardButtons: some View {
    HStack(spacing: 8) {
      Spacer()
      Button {
        goUp()
      } label: {
        Image(systemName: "chevron.up")
      }
      .disabled(focusedField == .email)
        
      Button {
        goDown()
      } label: {
        Image(systemName: "chevron.down")
      }
      .disabled(focusedField == .password)
    }
  }
  
  private var signInForm: some View {
    VStack(spacing: 0) {
      Spacer().frame(height: 16)
      signInHeaderView
      Spacer().frame(height: 24)
      fields
      Spacer().frame(height: 50)
      signInButton
      Spacer().frame(height: 64)
    }
    .padding(.horizontal, 30)
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 30))
    .padding(.horizontal, 24)
  }

  private var fields: some View {
    VStack(spacing: 20) {
      emailField
      passwordField
    }
  }
  
  private var emailField: some View {
    InputField(
      text: $viewModel.email,
      isFocused: $viewModel.isEmailFocused,
      isValidField: $viewModel.isValidEmail,
      placeholderText: String.Field.email
    )
    .keyboardType(.emailAddress)
    .textInputAutocapitalization(.never)
    .focused($focusedField, equals: .email)
    .modifier(
      FieldErrorModifier(
        title: viewModel.emailErrorMessage,
        isHidden: viewModel.isValidEmail
      )
    )
    .id(Field.email.rawValue)
    .onTapGesture {
      viewModel.isEmailFocused = true
    }
  }
  
  private var passwordField: some View {
    InputField(
      text: $viewModel.password,
      isFocused: $viewModel.isPasswordFocused,
      isValidField: $viewModel.isValidPassword,
      isShow: $viewModel.isShowPasswordField,
      placeholderText: String.Field.password,
      isSecureField: true
    )
    .keyboardType(.default)
    .textInputAutocapitalization(.never)
    .focused($focusedField, equals: .password)
    .modifier(
      FieldErrorModifier(
        title: viewModel.passwordErrorMessage,
        isHidden: viewModel.isValidPassword
      )
    )
    .id(Field.password.rawValue)
    .onTapGesture {
      viewModel.isPasswordFocused = true
    }
  }

  private var signInHeaderView: some View {
    Text(String.Button.signIn)
      .karmaFont(style: .bold22)
      .foregroundStyle(.rouge)
      .padding(.top, 20)
  }
  
  private var signInButton: some View {
    RoundedButton(name: String.Button.signIn) {
      // TODO: - SignIn Action
    }
    .disabled(!viewModel.isValidForm)
  }
  
  private func goUp() {
    guard let rawValue = focusedField?.rawValue,
          let status = Field(rawValue: rawValue - 1)
    else { return }
    focusedField = status
  }
  
  private func goDown() {
    guard let rawValue = focusedField?.rawValue,
          let status = Field(rawValue: rawValue + 1)
    else { return }
    focusedField = status
  }
  
}

#Preview {
  SignInScreen(viewModel: SignInViewModel(router: NavigationRouter()))
}
