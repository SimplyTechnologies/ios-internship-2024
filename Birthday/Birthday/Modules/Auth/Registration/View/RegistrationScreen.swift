//
//  RegistrationScreen.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

struct RegistrationScreen: View {
  
  private enum Field: Int, CaseIterable {
    case name, surname, email, password, repeatPassword
  }
  
  @StateObject var viewModel: RegistrationViewModel
  @FocusState private var focusedField: Field?
  @State private var scrollProxy: ScrollViewProxy? = nil
  
  var body: some View {
    content
  }
  
}

extension RegistrationScreen {
  
  private var content: some View {
    ZStack {
      Color.snow.ignoresSafeArea()
      VStack(spacing: 0) {
        NavigationBar {
          viewModel.router.pop()
        }
        ScrollViewReader { scrollReader in
          ScrollView(.vertical, showsIndicators: false) {
            Spacer().frame(maxHeight: 60)
            Spacer()
            registerForm
            Spacer()
            Spacer().frame(height: 40)
          }
          .disableBounces()
          .onAppear {
            self.scrollProxy = scrollReader
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
      Spacer().frame(height: 16)

      Text(String.Button.register)
        .foregroundStyle(Color.rouge)
        .karmaFont(style: .bold20)
      
      Spacer().frame(height: 30)
      
      VStack(spacing: 24) {
        nameField
        surnameField
        emailField
        passwordField
        repeatPasswordField
        registerButton
        Spacer().frame(height: 30)
      }
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
    .keyboardType(.default)
    .textInputAutocapitalization(.never)
    .focused($focusedField, equals: .name)
    .modifier(
      FieldErrorModifier(
        title: viewModel.nameErrorMessage,
        isHidden: viewModel.isValidName
      )
    )
    .id(Field.name.rawValue)
    .onTapGesture {
      viewModel.isNameFocused = true
    }
  }
  
  private var surnameField: some View {
    InputField(
      text: $viewModel.surname,
      isFocused: $viewModel.isSurnameFocused,
      isValidField: $viewModel.isValidSurname,
      placeholderText: String.Field.surname
    )
    .keyboardType(.default)
    .textInputAutocapitalization(.never)
    .focused($focusedField, equals: .surname)
    .modifier(
      FieldErrorModifier(
        title: viewModel.surnameErrorMessage,
        isHidden: viewModel.isValidSurname
      )
    )
    .id(Field.surname.rawValue)
    .onTapGesture {
      viewModel.isSurnameFocused = true
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
  
  private var repeatPasswordField: some View {
    InputField(
      text: $viewModel.repeatPassword,
      isFocused: $viewModel.isRepeatPasswordFocused,
      isValidField: $viewModel.isValidRepeatPassword,
      isShow: $viewModel.isShowPasswordField,
      placeholderText: String.Field.repeatPassword,
      isSecureField: true
    )
    .keyboardType(.default)
    .textInputAutocapitalization(.never)
    .focused($focusedField, equals: .repeatPassword)
    .modifier(
      FieldErrorModifier(
        title: viewModel.repeatPasswordErrorMessage,
        isHidden: viewModel.isValidRepeatPassword
      )
    )
    .id(Field.repeatPassword.rawValue)
    .onTapGesture {
      viewModel.isRepeatPasswordFocused = true
    }
  }
  
  private var registerButton: some View {
    RoundedButton(name: String.Button.register) {
      viewModel.register()
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
  RegistrationScreen(viewModel: RegistrationViewModel(router: NavigationRouter()))
}
