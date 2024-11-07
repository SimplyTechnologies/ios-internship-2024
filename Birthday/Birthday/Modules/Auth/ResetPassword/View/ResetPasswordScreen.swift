//
//  ResetPasswordScreen.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 30.10.24.
//

import SwiftUI

struct ResetPasswordScreen<T: ResetPasswordViewModeling>: View {
  
  private enum Field: Int, CaseIterable {
    case newPassword, repeatPassword
  }
  
  @StateObject var viewModel: T
  @EnvironmentObject var router: NavigationRouter
  @EnvironmentObject var appState: AppState
  @FocusState private var focusedField: Field?
  @State private var scrollProxy: ScrollViewProxy? = nil
  
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
    VStack(spacing: 0) {
      NavigationBar {
        router.pop()
      }
      GeometryReader { geo in
        ScrollViewReader { scrollReader in
          ScrollView {
            VStack(spacing: 0) {
              Spacer()
                .frame(height: geo.size.height * 0.1)
              password
                .padding(.bottom, 24)
              confirmPassword
                .padding(.bottom, 24)
              Spacer()
              doneButton
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 60)
            .frame(
              maxWidth: .infinity,
              minHeight: geo.size.height,
              alignment: .bottom
            )
            .onChange(of: focusedField) { newField in
              if let newField {
                withAnimation {
                  scrollProxy?.scrollTo(newField.rawValue, anchor: .center)
                }
              }
            }
          }
          .scrollIndicators(.hidden)
          .onAppear {
            self.scrollProxy = scrollReader
          }
        }
      }
    }
    .toolbar {
      ToolbarItem(placement: .keyboard) {
        keyboardButtons
      }
    }
  }
  
  private var password: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(String.Auth.newPassword)
        .foregroundStyle(Color.rouge.opacity(0.7))
        .karmaFont(style: .bold18)
      InputField(
        text: $viewModel.password,
        isFocused: $viewModel.isPasswordFocused,
        isValidField: $viewModel.isPasswordValid,
        placeholderText: String.Field.newPassword,
        isSecureField: true,
        backgroundColor: .white
      )
      .focused($focusedField, equals: .newPassword)
      .modifier(
        FieldErrorModifier(
          title: viewModel.passwordErrorMessage,
          isHidden: viewModel.isPasswordValid
        )
      )
      .id(Field.newPassword.rawValue)
    }
  }
  
  private var confirmPassword: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(String.Auth.repeatPassword)
        .foregroundStyle(Color.rouge.opacity(0.7))
        .karmaFont(style: .bold18)
      InputField(
        text: $viewModel.confirmPassword,
        isFocused: $viewModel.isRepeatPasswordFocused,
        isValidField: $viewModel.isConfirmPassValid,
        placeholderText: String.Field.repeatNewPassword,
        isSecureField: true,
        backgroundColor: .white
      )
      .focused($focusedField, equals: .repeatPassword)
      .modifier(
        FieldErrorModifier(
          title: viewModel.repeatPasswordErrorMessage,
          isHidden: viewModel.isConfirmPassValid
        )
      )
      .id(Field.repeatPassword.rawValue)
    }
  }
  
  private var doneButton: some View {
    RoundedButton(
      name: String.Auth.done,
      isLoading: viewModel.isLoading
    ) {
      UIApplication.shared.hideKeyboard()
      viewModel.changePassword(
        navigationAction: {
          router.resetNavigation(
            with: [
              LandingScreen.Screen.signIn(
                viewModel: SignInViewModel(
                  signInRepository: SignInDefaultRepository()
                )
              )
            ]
          )
        }
      )
    }
    .disabled(!viewModel.isValidForm || viewModel.isLoading)
  }
  
  private var keyboardButtons: some View {
    HStack(spacing: 8) {
      Spacer()
      Button {
        goUp()
      } label: {
        Image(systemName: "chevron.up")
      }
      .disabled(focusedField == .newPassword)
        
      Button {
        goDown()
      } label: {
        Image(systemName: "chevron.down")
      }
      .disabled(focusedField == .repeatPassword)
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
  ResetPasswordScreen(
    viewModel: ResetPasswordViewModel(
      forgotPasswordRepository: ForgotPasswordDefaultRepository(),
      passwordCode: "111111"
    )
  )
}
