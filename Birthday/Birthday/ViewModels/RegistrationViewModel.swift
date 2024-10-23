//
//  RegistrationViewModel.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import Combine
import SwiftUI

@MainActor
class RegistrationViewModel: ObservableObject {
  
  @Published var router: any Routable

  @Published var name: String = ""
  @Published var surname: String = ""
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var repeatPassword: String = ""
  
  @Published var isNameFocused: Bool = false
  @Published var isSurnameFocused: Bool = false
  @Published var isEmailFocused: Bool = false
  @Published var isPasswordFocused: Bool = false
  @Published var isRepeatPasswordFocused: Bool = false
  
  @Published var isValidName: Bool = true
  @Published var isValidSurname: Bool = true
  @Published var isValidEmail: Bool = true
  @Published var isValidPassword: Bool = true
  @Published var isValidRepeatPassword: Bool = true
  @Published var isValidForm: Bool = false
  @Published var isSamePasswords = true
  @Published var isShowPasswordField: Bool = false
  
  @Published var repeatPasswordErrorMessage: String = ""
  @Published var passwordErrorMessage: String = ""
  @Published var nameErrorMessage: String = ""
  @Published var surnameErrorMessage: String = ""
  @Published var emailErrorMessage: String = ""
  
  private var cancellables = Set<AnyCancellable>()
  
  init(router: any Routable) {
    self.router = router
    
    $password
      .sink { [weak self] passwordText in
        guard let self else { return }
        if password != passwordText && !repeatPassword.isEmpty {
          repeatPassword = ""
        }
      }
      .store(in: &cancellables)
        
    $isNameFocused
      .sink { [weak self] isFocused in
        guard let self else { return }
        if isNameFocused && !isFocused {
          validateName()
        }
      }
      .store(in: &cancellables)
    
    $isSurnameFocused
      .sink { [weak self] isFocused in
        guard let self else { return }
        if isSurnameFocused && !isFocused {
          validateSurname()
        }
      }
      .store(in: &cancellables)
    
    $isEmailFocused
      .sink { [weak self] isFocused in
        guard let self else { return }
        if isEmailFocused && !isFocused {
          validateEmail()
        }
      }
      .store(in: &cancellables)
    
    $isPasswordFocused
      .sink { [weak self] isFocused in
        guard let self else { return }
        if isPasswordFocused && !isFocused {
          validatePassword()
        }
      }
      .store(in: &cancellables)
    
    $isRepeatPasswordFocused
      .sink { [weak self] isFocused in
        guard let self else { return }
        if isRepeatPasswordFocused && !isFocused {
          validateRepeatPassword()
        }
      }
      .store(in: &cancellables)
    
    $isValidName
      .sink { [weak self] isValid in
        guard let self else { return }
        if !isValid {
          let message = name.isEmpty ? String.Field.emptyName : String.Field.invalidName
          nameErrorMessage = message
        }
      }
      .store(in: &cancellables)
    
    $isValidSurname
      .sink { [weak self] isValid in
        guard let self else { return }
        if !isValid {
          let message = surname.isEmpty ? String.Field.emptySurname : String.Field.invalidSurname
          surnameErrorMessage = message
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
    
    $isValidRepeatPassword
      .sink { [weak self] isValid in
        guard let self else { return }
        if !isValid {
          if !isSamePasswords {
            repeatPasswordErrorMessage = String.Field.invalidRepeatPassword
          } else if repeatPassword.isEmpty {
            repeatPasswordErrorMessage = String.Field.emptyRepeatPassword
          }
        }
      }
      .store(in: &cancellables)
  }
  
  func register() {
    validateForm()
    if isValidForm {
      // Register
    }
  }
  
  private func validateForm() {
    validateName()
    validateSurname()
    validateEmail()
    validatePassword()
    validateRepeatPassword()
    let isValidFullName = isValidName && isValidSurname
    let isValidPasswords = isValidPassword && isValidRepeatPassword && isSamePasswords
    isValidForm = isValidFullName && isValidEmail && isValidPasswords
  }
  
  func validateName() {
    isValidName = name.isValidName
  }
  
  func validateSurname() {
    isValidSurname = surname.isValidName
  }
  
  func validateEmail() {
    isValidEmail = email.isValidEmail
  }
  
  func validatePassword() {
    isValidPassword = password.isValidPassword
  }
  
  func validateRepeatPassword() {
    isSamePasswords = password == repeatPassword
    isValidRepeatPassword = repeatPassword.isValidPassword && isSamePasswords
  }
  
}
