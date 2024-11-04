//
//  SignInViewModel.swift
//  Birthday
//
//  Created by Sona on 21.10.24.
//

import Combine
import SwiftUI

class SignInViewModel: SignInViewModeling {
  
  @Published var isLoading: Bool = false
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var isEmailFocused: Bool = false
  @Published var isPasswordFocused: Bool = false
  @Published var isValidEmail: Bool = true
  @Published var isValidPassword: Bool = true
  @Published var isShowPasswordField: Bool = false
  @Published var isShowMessage: Bool = false
  
  var passwordErrorMessage: String = ""
  var emailErrorMessage: String = ""
  var toastMessage: String = ""
  var isSuccessMessage: Bool = false
  let id: UUID = UUID()
  
  private let signInRepository: SignInRepository
  private var cancellables = Set<AnyCancellable>()
  
  private var hasEmptyField: Bool {
    email.isEmpty || password.isEmpty
  }
  
  var isValidForm: Bool {
    if hasEmptyField { return false }
    return isValidEmail && isValidPassword
  }
  
  init(
    signInRepository: SignInRepository,
    email: String = "",
    password: String = ""
  ) {
    self.signInRepository = signInRepository
    self.email = email
    self.password = password
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
        if !isValidPassword {
          let message = passwordText.isEmpty ? String.Field.emptyPassword : String.Field.invalidPassword
          passwordErrorMessage = message
        }
      }
      .store(in: &cancellables)
  }
  
  func signIn(completion: @escaping () -> Void) {
    isLoading = true
    isShowMessage = false
    signInRepository.singIn(email: email, password: password)
      .sink { [weak self] result in
        guard let self else { return }
        isLoading = false
        switch result {
        case .failure(let error):
          Console.log("❌ Error: ", error)
          showToast(message: error.localizedDescription, isSuccess: false)
        default: break
        }
      } receiveValue: { data in
        let accessToken = data.login.accessToken
        if !accessToken.isEmpty {
          AppController.shared.setLogedIn(accessToken)
          completion()
        }
      }
      .store(in: &cancellables)
  }
  
}
