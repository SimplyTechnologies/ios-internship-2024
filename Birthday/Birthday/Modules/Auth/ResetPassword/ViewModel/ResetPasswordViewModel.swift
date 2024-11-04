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
  @Published var isPasswordValid: Bool = false
  @Published var isConfirmPassValid: Bool = false
  @Published var password: String = ""
  @Published var confirmPassword: String = ""
  
  var isSuccessMessage: Bool = false
  var toastMessage: String = ""
  let id: UUID = UUID()
  
  private let forgotPasswordRepository: ForgotPasswordRepository
  private let passwordCode: String
  private var cancelables = Set<AnyCancellable>()

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
      .store(in: &cancelables)
  }
  
  private func setupPasswordValidation() {
    $password
      .map {
        $0.isValidPassword
      }
      .assign(to: &$isPasswordValid)
  }
  
  private func setupConfirmPassValidation() {
    $confirmPassword
      .map {
        $0.isValidPassword && $0 == self.password
      }
      .assign(to: &$isConfirmPassValid)
  }
  
  private func showToast(message: String, isSuccess: Bool) {
    toastMessage = message
    isSuccessMessage = isSuccess
    isShowMessage = true
  }
  
}
