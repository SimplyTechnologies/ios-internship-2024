//
//  ForgotPasswordViewModel.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 29.10.24.
//

import Foundation
import Combine

final class ForgotPasswordViewModel: ForgotPasswordViewModeling {
  
  @Published var isLoading: Bool = false
  @Published var email: String = ""
  @Published var passwordCode: String = ""
  @Published var isCodeValid: Bool = false
  @Published var isEmailValid: Bool = false
  @Published var actualCode: String = ""
  
  private let forgotPasswordRepository: ForgotPasswordRepository
  private var cancelables = Set<AnyCancellable>()
  
  init(forgotPasswordRepository: ForgotPasswordRepository) {
    self.forgotPasswordRepository = forgotPasswordRepository
    setupCodeValidation()
    setupEmailValidation()
  }
  
  func askForCode() {
    isLoading = true
    forgotPasswordRepository.getCode(email: email)
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .failure(let error):
          Console.log(error)
        default: break
        }
      } receiveValue: { [weak self]  code in
        self?.actualCode = code
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
  
}
