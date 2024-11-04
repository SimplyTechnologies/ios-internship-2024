//
//  SignInScreen.swift
//  Birthday
//
//  Created by Sona on 22.10.24.
//

import SwiftUI

struct SignInScreen<T: SignInViewModeling>: View {
  
  private enum Field: Int, CaseIterable {
    case email, password
  }
  
  @StateObject var viewModel: T
  @EnvironmentObject var appState: AppState
  @EnvironmentObject var router: NavigationRouter
  @FocusState private var focusedField: Field?
  @State private var scrollProxy: ScrollViewProxy? = nil
  
  var body: some View {
    content
      .onChange(of: viewModel.isShowMessage) { isShow in
        appState.isShowMessage = isShow
        if isShow {
          appState.isSuccessMessage = viewModel.isSuccessMessage
          appState.message = viewModel.toastMessage
        }
      }
  }
  
}

extension SignInScreen {
  
  private var content: some View {
    ZStack {
      Color.lightPink
        .ignoresSafeArea()
      VStack(spacing: 0) {
        NavigationBar {
          router.pop()
        }
        GeometryReader { geo in
          ScrollViewReader { scrollReader in
            ScrollView(.vertical, showsIndicators: false) {
              Spacer()
                .frame(height: geo.size.height * 0.2)
              Spacer()
              signInForm
              Spacer()
                .frame(height: geo.size.height * 0.2)
              Spacer()
            }
            .onAppear {
              self.scrollProxy = scrollReader
            }
          }
        }
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
      Spacer()
        .frame(height: 16)
      signInHeaderView
      Spacer()
        .frame(height: 24)
      fields
      Spacer()
        .frame(height: 24)
      forgotPasswordButton
      Spacer()
        .frame(height: 24)
      signInButton
      Spacer()
        .frame(height: 64)
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
    .animation(.default, value: viewModel.isValidEmail)
    .animation(.default, value: viewModel.isValidPassword)
  }
  
  private var emailField: some View {
    InputField(
      text: $viewModel.email,
      isFocused: $viewModel.isEmailFocused,
      isValidField: $viewModel.isValidEmail,
      placeholderText: String.Field.email
    )
    .keyboardType(.emailAddress)
    .focused($focusedField, equals: .email)
    .modifier(
      FieldErrorModifier(
        title: viewModel.emailErrorMessage,
        isHidden: viewModel.isValidEmail
      )
    )
    .id(Field.email.rawValue)
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
    .focused($focusedField, equals: .password)
    .modifier(
      FieldErrorModifier(
        title: viewModel.passwordErrorMessage,
        isHidden: viewModel.isValidPassword
      )
    )
    .id(Field.password.rawValue)
  }
  
  private var signInHeaderView: some View {
    Text(String.Button.signIn)
      .karmaFont(style: .bold22)
      .foregroundStyle(.rouge)
      .padding(.top, 20)
  }
  
  private var signInButton: some View {
    RoundedButton(
      name: String.Button.signIn,
      isLoading: viewModel.isLoading
    ) {
      UIApplication.shared.hideKeyboard()
      viewModel.signIn {
        appState.isUserLogedIn = true
      }
    }
    .disabled(!viewModel.isValidForm || viewModel.isLoading)
  }
  
  private var forgotPasswordButton: some View {
    HStack {
      Spacer()
      Button {
        router.push(LandingScreen.Screen.forgotPassword)
      } label: {
        Text(String.Auth.forgot)
          .foregroundStyle(Color.rouge)
          .karmaFont(style: .bold12)
      }
      .frame(alignment: .trailing)
    }
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
  SignInScreen(
    viewModel: SignInViewModel(
      signInRepository: SignInDefaultRepository()
    )
  )
}
