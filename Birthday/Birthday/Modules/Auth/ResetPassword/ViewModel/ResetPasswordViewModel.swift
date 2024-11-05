//
//  ResetPasswordViewModel.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 30.10.24.
//

import Foundation
import Combine

final class ResetPasswordViewModel: ResetPasswordViewModeling {
  
  @Published var isShowMessage: Bool = false
  @Published var isLoading: Bool = false
  @Published var isPasswordValid: Bool = true
  @Published var isConfirmPassValid: Bool = true
  @Published var password: String = ""
  @Published var confirmPassword: String = ""
  @Published var isPasswordFocused: Bool = false
  @Published var isRepeatPasswordFocused: Bool = false
  @Published var isSamePasswords: Bool = false
  @Published var isShowPasswordField: Bool = false
  
  var repeatPasswordErrorMessage: String = ""
  var passwordErrorMessage: String = ""
  var isSuccessMessage: Bool = false
  var toastMessage: String = ""
  let id: UUID = UUID()
  
  private var hasEmptyField: Bool {
    password.isEmpty || confirmPassword.isEmpty
  }
  
  var isValidForm: Bool {
    guard !hasEmptyField else { return false }
    return isPasswordValid && isConfirmPassValid && isSamePasswords
  }
  
  private let forgotPasswordRepository: ForgotPasswordRepository
  private let passwordCode: String
  private var cancellables = Set<AnyCancellable>()

  init(forgotPasswordRepository: ForgotPasswordRepository, passwordCode: String) {
    self.forgotPasswordRepository = forgotPasswordRepository
    self.passwordCode = passwordCode
    setupPasswordValidation()
    setupConfirmPassValidation()
  }
  
  func changePassword(navigationAction: @escaping () -> ()) {
    isLoading = true
    isShowMessage = false
    let payload = ResetPasswordPayload(
      code: passwordCode,
      password: password, confirmPassword: confirmPassword
    )
    forgotPasswordRepository.confirmCode(payload: payload)
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .failure(let error):
          Console.log(error)
          self?.showToast(message: error.localizedDescription, isSuccess: false)
        default: break
        }
      } receiveValue: { [weak self] isChanged in
        if isChanged {
          self?.showToast(message: String.Toast.change, isSuccess: true)
          navigationAction()
        }
      }
      .store(in: &cancellables)
  }
  
  private func setupPasswordValidation() {
    $password
      .removeDuplicates()
      .dropFirst()
      .sink { [weak self] passwordText in
        guard let self else { return }
        isPasswordValid = passwordText.isValidPassword
        if password != passwordText && !confirmPassword.isEmpty {
          confirmPassword = ""
        }
        if !isPasswordValid {
          passwordErrorMessage = passwordText.isEmpty ? String.Field.emptyPassword : String.Field.invalidPassword
        }
      }
      .store(in: &cancellables)
  }
  
  private func setupConfirmPassValidation() {
    $confirmPassword
      .removeDuplicates()
      .dropFirst()
      .sink { [weak self] repeatPasswordText in
        guard let self else { return }
        isSamePasswords = password == repeatPasswordText
        isConfirmPassValid = repeatPasswordText.isValidPassword && isSamePasswords
        if !isConfirmPassValid {
          if !isSamePasswords {
            repeatPasswordErrorMessage = String.Field.invalidRepeatPassword
          } else if repeatPasswordText.isEmpty {
            repeatPasswordErrorMessage = String.Field.emptyRepeatPassword
          }
        }
      }
      .store(in: &cancellables)
  }
  
  private func showToast(message: String, isSuccess: Bool) {
    toastMessage = message
    isSuccessMessage = isSuccess
    isShowMessage = true
  }
  
}
