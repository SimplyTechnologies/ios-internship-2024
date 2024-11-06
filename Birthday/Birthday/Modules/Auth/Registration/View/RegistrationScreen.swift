//
//  RegistrationScreen.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

struct RegistrationScreen<T: RegistrationViewModeling>: View {
  
  private enum Field: Int, CaseIterable {
    case name, surname, email, password, repeatPassword
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

extension RegistrationScreen {
  
  private var content: some View {
    ZStack {
      Color.lightPink.ignoresSafeArea()
      VStack(spacing: 0) {
        NavigationBar {
          router.pop()
        }
        GeometryReader { geo in
          ScrollViewReader { scrollReader in
            ScrollView(.vertical, showsIndicators: false) {
              Spacer()
                .frame(height: geo.size.height * 0.1)
              Spacer()
              registerForm
              Spacer()
                .frame(minHeight: 40)
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
      .disabled(focusedField == .name)
        
      Button {
        goDown()
      } label: {
        Image(systemName: "chevron.down")
      }
      .disabled(focusedField == .repeatPassword)
    }
  }
  
  private var registerForm: some View {
    VStack(spacing: 0) {
      Text(String.Button.register)
        .foregroundStyle(Color.rouge)
        .karmaFont(style: .bold20)
        .padding(.top, 16)
        .padding(.bottom, 30)
      
      VStack(spacing: 24) {
        nameField
        surnameField
        emailField
        passwordField
        repeatPasswordField
        registerButton
          .padding(.bottom, 30)
      }
      .animation(.default, value: viewModel.isValidName)
      .animation(.default, value: viewModel.isValidSurname)
      .animation(.default, value: viewModel.isValidEmail)
      .animation(.default, value: viewModel.isValidPassword)
      .animation(.default, value: viewModel.isValidRepeatPassword)
      .onChange(of: focusedField) { newField in
        if let newField {
          withAnimation {
            scrollProxy?.scrollTo(newField.rawValue, anchor: .center)
          }
        }
      }
    }
    .padding(.horizontal, 30)
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 30))
    .padding(.horizontal, 24)
  }
  
  private var nameField: some View {
    InputField(
      text: $viewModel.name,
      isFocused: $viewModel.isNameFocused,
      isValidField: $viewModel.isValidName,
      placeholderText: String.Field.name
    )
    .onChange(of: viewModel.name) { _ in
      viewModel.name.limitText(18)
    }
    .focused($focusedField, equals: .name)
    .textInputAutocapitalization(.words)
    .modifier(
      FieldErrorModifier(
        title: viewModel.nameErrorMessage,
        isHidden: viewModel.isValidName
      )
    )
    .id(Field.name.rawValue)
  }
  
  private var surnameField: some View {
    InputField(
      text: $viewModel.surname,
      isFocused: $viewModel.isSurnameFocused,
      isValidField: $viewModel.isValidSurname,
      placeholderText: String.Field.surname
    )
    .onChange(of: viewModel.surname) { _ in
      viewModel.surname.limitText(18)
    }
    .textInputAutocapitalization(.words)
    .focused($focusedField, equals: .surname)
    .modifier(
      FieldErrorModifier(
        title: viewModel.surnameErrorMessage,
        isHidden: viewModel.isValidSurname
      )
    )
    .id(Field.surname.rawValue)
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
  
  private var repeatPasswordField: some View {
    InputField(
      text: $viewModel.repeatPassword,
      isFocused: $viewModel.isRepeatPasswordFocused,
      isValidField: $viewModel.isValidRepeatPassword,
      isShow: $viewModel.isShowPasswordField,
      placeholderText: String.Field.repeatPassword,
      isSecureField: true
    )
    .focused($focusedField, equals: .repeatPassword)
    .modifier(
      FieldErrorModifier(
        title: viewModel.repeatPasswordErrorMessage,
        isHidden: viewModel.isValidRepeatPassword
      )
    )
    .id(Field.repeatPassword.rawValue)
  }
  
  private var registerButton: some View {
    RoundedButton(
      name: String.Button.register,
      isLoading: viewModel.isLoading
    ) {
      UIApplication.shared.hideKeyboard()
      viewModel.register {
        router.resetNavigation(
          with:
            [
              LandingScreen.Screen.signIn(
                viewModel: SignInViewModel(
                  signInRepository: SignInDefaultRepository(),
                  email: viewModel.email
                )
              )
            ]
        )
      }
    }
    .disabled(!viewModel.isValidForm || viewModel.isLoading)
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
  RegistrationScreen(
    viewModel: RegistrationViewModel(
      registrationRepository: RegistrationDefaultRepository()
    )
  )
}
