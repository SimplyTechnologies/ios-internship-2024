//
//  SignInViewModel.swift
//  Birthday
//
//  Created by Sona on 21.10.24.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
  
  @Published var router: any Routable
  
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var isEmailFocused: Bool = false
  @Published var isPasswordFocused: Bool = false
  @Published var isValidEmail: Bool = true
  @Published var isValidPassword: Bool = true
  @Published var isValidForm: Bool = false
  @Published var isShowPasswordField: Bool = false
  @Published var passwordErrorMessage: String = ""
  @Published var emailErrorMessage: String = ""
  
  private var cancellables = Set<AnyCancellable>()
  
  private var hasEmptyField: Bool {
    email.isEmpty || password.isEmpty
  }
  
  init(router: any Routable) {
    self.router = router

    $isEmailFocused
      .sink { [weak self] isFocused in
        guard let self else { return }
        if isEmailFocused && !isFocused {
          validateEmail()
          validateForm()
        }
      }
      .store(in: &cancellables)
    
    $isPasswordFocused
      .sink { [weak self] isFocused in
        guard let self else { return }
        if isPasswordFocused && !isFocused {
          validatePassword()
          validateForm()
        }
      }
      .store(in: &cancellables)
    
    $isValidEmail
      .sink { [weak self] isValid in
        guard let self else { return }
        if !isValid {
          let message = email.isEmpty ? String.Field.emptyEmail : String.Field.invalidEmail
          emailErrorMessage = message
        }
      }
      .store(in: &cancellables)
    
    $isValidPassword
      .sink { [weak self] isValid in
        guard let self else { return }
        if !isValid {
          let message = password.isEmpty ? String.Field.emptyPassword : String.Field.invalidPassword
          passwordErrorMessage = message
        }
      }
      .store(in: &cancellables)
  }
  
  private func validateForm() {
    if !hasEmptyField {
      validateEmail()
      validatePassword()
      isValidForm = isValidEmail && isValidPassword
    }
  }
  
  private func validateEmail() {
    isValidEmail = email.isValidEmail
  }
  
  private func validatePassword() {
    isValidPassword = password.isValidPassword
  }

}
