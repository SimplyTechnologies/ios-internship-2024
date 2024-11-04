//
//  RegistrationViewModel.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import Combine
import SwiftUI

class RegistrationViewModel: RegistrationViewModeling {
  
  @Published var isLoading: Bool = false
  @Published var isShowMessage: Bool = false

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
  @Published var isSamePasswords: Bool = true
  @Published var isShowPasswordField: Bool = false
  
  var repeatPasswordErrorMessage: String = ""
  var passwordErrorMessage: String = ""
  var nameErrorMessage: String = ""
  var surnameErrorMessage: String = ""
  var emailErrorMessage: String = ""
  var toastMessage: String = ""
  var isSuccessMessage: Bool = false
  let id: UUID = UUID()
  
  private let registrationRepository: RegistrationRepository
  private var cancellables = Set<AnyCancellable>()
  
  private var hasEmptyField: Bool {
    name.isEmpty || surname.isEmpty || email.isEmpty || password.isEmpty || repeatPassword.isEmpty
  }
  
  var isValidForm: Bool {
    if hasEmptyField { return false }
    
    let isValidFullName = isValidName && isValidSurname
    let isValidPasswords = isValidPassword && isValidRepeatPassword && isSamePasswords
    return isValidFullName && isValidEmail && isValidPasswords
  }
  
  init(registrationRepository: RegistrationRepository) {
    self.registrationRepository = registrationRepository
    
    $name
      .removeDuplicates()
      .dropFirst()
      .sink { [weak self] name in
        guard let self else { return }
        self.name = name
        isValidName = name.isValidName
        if !isValidName {
          let message = name.isEmpty ? String.Field.emptyName : String.Field.invalidName
          nameErrorMessage = message
        }
      }
      .store(in: &cancellables)
    
    $surname
      .removeDuplicates()
      .dropFirst()
      .sink { [weak self] surname in
        guard let self else { return }
        isValidSurname = surname.isValidName
        if !isValidSurname {
          let message = surname.isEmpty ? String.Field.emptySurname : String.Field.invalidSurname
          surnameErrorMessage = message
        }
      }
      .store(in: &cancellables)
    
    $email
      .removeDuplicates()
      .dropFirst()
      .sink { [weak self] email in
        guard let self else { return }
        isValidEmail = email.isValidEmail
        if !isValidEmail {
          let message = email.isEmpty ? String.Field.emptyEmail : String.Field.invalidEmail
          emailErrorMessage = message
        }
      }
      .store(in: &cancellables)
    
    $password
      .removeDuplicates()
      .dropFirst()
      .sink { [weak self] passwordText in
        guard let self else { return }
        isValidPassword = passwordText.isValidPassword
        if password != passwordText && !repeatPassword.isEmpty {
          repeatPassword = ""
        }
        if !isValidPassword {
          let message = passwordText.isEmpty ? String.Field.emptyPassword : String.Field.invalidPassword
          passwordErrorMessage = message
        }
      }
      .store(in: &cancellables)
    
    $repeatPassword
      .removeDuplicates()
      .dropFirst()
      .sink { [weak self] repeatPasswordText in
        guard let self else { return }
        isSamePasswords = password == repeatPasswordText
        isValidRepeatPassword = repeatPasswordText.isValidPassword && isSamePasswords
        if !isValidRepeatPassword {
          if !isSamePasswords {
            repeatPasswordErrorMessage = String.Field.invalidRepeatPassword
          } else if repeatPasswordText.isEmpty {
            repeatPasswordErrorMessage = String.Field.emptyRepeatPassword
          }
        }
      }
      .store(in: &cancellables)
  }
  
  func register(completion: @escaping () -> Void) {
    isLoading = true
    isShowMessage = false
    let registrationPayload: RegistrationPayload = .init(
      firstName: name,
      lastName: surname,
      email: email,
      password: password
    )
      
    registrationRepository.singUp(registrationPayload)
      .sink { [weak self] result in
        guard let self else { return }
        isLoading = false
        switch result {
        case .failure(let error):
          Console.log("❌ Error: ", error)
          showToast(message: error.localizedDescription, isSuccess: false)
        default: break
        }
      } receiveValue: { [weak self] data in
        guard let self else { return }
        let user = User(dto: data.signUp)
        Console.log("User is : \(user)")
        showToast(message: String.Toast.register, isSuccess: true)
        completion()
      }
      .store(in: &cancellables)
  }
  
}
