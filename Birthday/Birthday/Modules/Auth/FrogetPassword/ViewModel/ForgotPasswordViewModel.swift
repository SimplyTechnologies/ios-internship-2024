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
  @Published var isCodeValid: Bool = true
  @Published var isEmailValid: Bool = true
  @Published var actualCode: String = ""
  @Published var isEmailFocused: Bool = false
  @Published var isCodeFocused: Bool = false
  
  var isSuccessMessage: Bool = false
  var toastMessage: String = ""
  var emailErrorMessage: String = ""
  var codeErrorMessage: String = ""
  let id: UUID = UUID()
  
  var isGetCodeDisabled: Bool {
    !isEmailValid || email.isEmpty || isLoading
  }

  private let forgotPasswordRepository: ForgotPasswordRepository
  private var cancellables = Set<AnyCancellable>()
  
  init(forgotPasswordRepository: ForgotPasswordRepository) {
    self.forgotPasswordRepository = forgotPasswordRepository
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
      .store(in: &cancellables)
  }
  
  private func setupCodeValidation() {
    $passwordCode
      .removeDuplicates()
      .dropFirst()
      .sink { [weak self] code in
        guard let self else { return }
        isCodeValid = code == actualCode && !code.isEmpty && code.count == 6
        if !isCodeValid {
          codeErrorMessage = code.isEmpty ? String.Field.emptyCode : String.Field.invalidCode
        }
      }
      .store(in: &cancellables)
  }
  
  private func setupEmailValidation() {
    $email
      .removeDuplicates()
      .dropFirst()
      .sink { [weak self] email in
        guard let self else { return }
        isEmailValid = email.isValidEmail
        if !isEmailValid {
          emailErrorMessage = email.isEmpty ? String.Field.emptyEmail : String.Field.invalidEmail
        }
      }
      .store(in: &cancellables)
  }
  
  func checkCode(completion: () -> ()) {
    if passwordCode == actualCode {
      completion()
    } else {
      isShowMessage = false
      showToast(message: String.Toast.wrongCode, isSuccess: false)
    }
  }
  
}
