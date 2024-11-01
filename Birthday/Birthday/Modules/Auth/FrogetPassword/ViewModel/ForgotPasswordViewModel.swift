//
//  ForgotPasswordViewModel.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 29.10.24.
//

import Foundation
import Combine

final class ForgotPasswordViewModel: ForgotPasswordViewModeling {
  
  @Published var isShowMessage: Bool = false
  @Published var isLoading: Bool = false
  @Published var email: String = ""
  @Published var passwordCode: String = ""
  @Published var isCodeValid: Bool = false
  @Published var isEmailValid: Bool = true
  @Published var actualCode: String = ""
  
  var isSuccessMessage: Bool = false
  var toastMessage: String = ""
  
  private let forgotPasswordRepository: ForgotPasswordRepository
  private var cancelables = Set<AnyCancellable>()
  
  init(forgotPasswordRepository: ForgotPasswordRepository) {
    self.forgotPasswordRepository = forgotPasswordRepository
    setupCodeValidation()
    setupEmailValidation()
  }
  
  func getCode() {
    isLoading = true
    isShowMessage = false
    forgotPasswordRepository.getCode(email: email)
      .sink { [weak self] result in
        guard let self else { return}
        isLoading = false
        switch result {
        case .failure(let error):
          Console.log(error)
          showToast(message: error.localizedDescription, isSuccess: false)
        default: break
        }
      } receiveValue: { [weak self] code in
        guard let self else { return }
        actualCode = code
        showToast(message: String.Toast.checkEmail, isSuccess: true)
      }
      .store(in: &cancelables)
  }
  
  private func setupCodeValidation() {
    $passwordCode
      .map { [weak self] in
        $0 == self?.actualCode && !$0.isEmpty && $0.count == 6
      }
      .assign(to: &$isCodeValid)
  }
  
  private func setupEmailValidation() {
    $email
      .map {
        $0.isValidEmail
      }
      .assign(to: &$isEmailValid)
  }
  
  func checkCode(complition: @escaping () -> ()) {
    isShowMessage = false
    if passwordCode == actualCode {
      complition()
    } else {
      showToast(message: String.Toast.wrongCode, isSuccess: false)
    }
  }
  
}
