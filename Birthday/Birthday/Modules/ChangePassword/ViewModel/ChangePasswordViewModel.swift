//
//  ChangePasswordViewModel.swift
//  Birthday
//
//  Created by Narek on 28.10.24.
//

import Combine
import SwiftUI

final class ChangePasswordViewModel: ChangePasswordViewModeling {
  
  @Published var isLoading: Bool = false
  
  @Published var oldPassword: String = ""
  @Published var newPassword: String = ""
  @Published var repeatPassword: String = ""
  
  @Published var isOldPasswordFocused: Bool = false
  @Published var isNewPasswordFocused: Bool = false
  @Published var isRepeatPasswordFocused: Bool = false
  
  @Published var isValidOldPassword: Bool = true
  @Published var isValidNewPassword: Bool = true
  @Published var isValidRepeatPassword: Bool = true
  @Published var isValidForm: Bool = false
  @Published var isSamePasswords = true
  
  @Published var isShowOldPassword: Bool = false
  @Published var isShowNewPassword: Bool = false
  @Published var isShowRepeatPassword: Bool = false
  
  @Published var oldPasswordErrorMessage: String = ""
  @Published var newPasswordErrorMessage: String = ""
  @Published var repeatPasswordErrorMessage: String = ""
  
  var id: UUID
  
  private let changePasswordRepository: ChangePasswordRepository
  private var cancellables = Set<AnyCancellable>()
  
  private var hasEmptyField: Bool {
    oldPassword.isEmpty || newPassword.isEmpty || repeatPassword.isEmpty
  }
  
  init(changePasswordRepository: ChangePasswordRepository) {
    self.changePasswordRepository = changePasswordRepository
    self.id = UUID()

    $isOldPasswordFocused
      .sink { [weak self] isFocused in
        guard let self else { return }
        if isOldPasswordFocused && !isFocused {
          validateOldPassword()
          validateForm()
        }
      }
      .store(in: &cancellables)
    
    $isNewPasswordFocused
      .sink { [weak self] isFocused in
        guard let self else { return }
        if isNewPasswordFocused && !isFocused {
          validateNewPassword()
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
    
    $isValidOldPassword
      .sink { [weak self] isValid in
        guard let self else { return }
        if !isValid {
          let message = oldPassword.isEmpty ? String.Field.emptyPassword : String.Field.invalidPassword
          oldPasswordErrorMessage = message
        }
      }
      .store(in: &cancellables)
    
    $isValidNewPassword
      .sink { [weak self] isValid in
        guard let self else { return }
        if !isValid {
          let message = newPassword.isEmpty ? String.Field.emptyPassword : String.Field.invalidPassword
          newPasswordErrorMessage = message
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
  
  func changePassword(completion: @escaping () -> Void ) {
    validateForm()
    if isValidForm {
      isLoading = true

      changePasswordRepository.changePassword(oldPassword: oldPassword, newPassword: newPassword)
        .sink { [weak self] result in
          self?.isLoading = false
          switch result {
          case .failure(let error):
            Console.log("❌ Error: \(error)")
          default: break
          }
        } receiveValue: { data in
          let isChanged = data.changePassword
          if isChanged {
            completion()
          }
        }
        .store(in: &cancellables)
    }
  }
  
  private func validateForm() {
    if !hasEmptyField {
      validateOldPassword()
      validateNewPassword()
      validateRepeatPassword()
      isValidForm = isValidOldPassword && isValidNewPassword && isValidRepeatPassword && isSamePasswords
    }
  }
  
  private func validateOldPassword() {
    isValidOldPassword = oldPassword.isValidPassword
  }
  
  private func validateNewPassword() {
    isValidNewPassword = newPassword.isValidPassword
  }
  
  private func validateRepeatPassword() {
    isSamePasswords = newPassword == repeatPassword
    isValidRepeatPassword = repeatPassword.isValidPassword && isSamePasswords
  }
  
}
