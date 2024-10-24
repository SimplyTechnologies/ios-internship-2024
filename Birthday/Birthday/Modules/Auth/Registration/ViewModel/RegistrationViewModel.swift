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
  @Published var isLoading: Bool = false

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
  
  private let registrationRepository: RegistrationRepository
  private var cancellables = Set<AnyCancellable>()
  
  private var hasEmptyField: Bool {
    name.isEmpty || surname.isEmpty || email.isEmpty || password.isEmpty || repeatPassword.isEmpty
  }
  
  init(router: any Routable, registrationRepository: RegistrationRepository) {
    self.router = router
    self.registrationRepository = registrationRepository
    
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
          validateForm()
        }
      }
      .store(in: &cancellables)
    
    $isSurnameFocused
      .sink { [weak self] isFocused in
        guard let self else { return }
        if isSurnameFocused && !isFocused {
          validateSurname()
          validateForm()
        }
      }
      .store(in: &cancellables)
    
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
    
    $isRepeatPasswordFocused
      .sink { [weak self] isFocused in
        guard let self else { return }
        if isRepeatPasswordFocused && !isFocused {
          validateRepeatPassword()
          validateForm()
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
      isLoading = true
      registrationRepository.singUp(
        firstName: name,
        lastName: surname,
        email: email,
        password: password
      )
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .failure(let error):
          Console.log("❌ Error: \(error)")
        default: break
        }
      } receiveValue: { [weak self] data in
        guard let self else { return }
        router.resetNavigation(with: [LandingScreen.Screen.signIn])
        let user = User(dto: data.signUp)
        Console.log("User is : \(user)")
      }
      .store(in: &cancellables)
    }
  }
  
  private func validateForm() {
    if !hasEmptyField {
      validateName()
      validateSurname()
      validateEmail()
      validatePassword()
      validateRepeatPassword()
      let isValidFullName = isValidName && isValidSurname
      let isValidPasswords = isValidPassword && isValidRepeatPassword && isSamePasswords
      isValidForm = isValidFullName && isValidEmail && isValidPasswords
    }
  }
  
  private func validateName() {
    isValidName = name.isValidName
  }
  
  private func validateSurname() {
    isValidSurname = surname.isValidName
  }
  
  private func validateEmail() {
    isValidEmail = email.isValidEmail
  }
  
  private func validatePassword() {
    isValidPassword = password.isValidPassword
  }
  
  private func validateRepeatPassword() {
    isSamePasswords = password == repeatPassword
    isValidRepeatPassword = repeatPassword.isValidPassword && isSamePasswords
  }
  
}
