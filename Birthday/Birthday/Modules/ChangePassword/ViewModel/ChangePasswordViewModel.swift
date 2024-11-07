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
  @Published var isSamePasswords = true
  @Published var isShowMessage: Bool = false
  
  let id: UUID = UUID()
  var oldPasswordErrorMessage: String = ""
  var newPasswordErrorMessage: String = ""
  var repeatPasswordErrorMessage: String = ""
  var toastMessage: String = ""
  var isSuccessMessage: Bool = false
  
  private let changePasswordRepository: ChangePasswordRepository
  private var cancellables = Set<AnyCancellable>()
  
  private var hasEmptyField: Bool {
    oldPassword.isEmpty || newPassword.isEmpty || repeatPassword.isEmpty
  }
  
  var isValidForm: Bool {
    guard !hasEmptyField else { return false }
    return isValidOldPassword && isValidNewPassword && isValidRepeatPassword && isSamePasswords
  }
  
  init(changePasswordRepository: ChangePasswordRepository) {
    self.changePasswordRepository = changePasswordRepository
    
    $oldPassword
      .removeDuplicates()
      .dropFirst()
      .sink { [weak self] passwordText in
        guard let self else { return }
        isValidOldPassword = passwordText.isValidPassword
        if !isValidOldPassword {
          oldPasswordErrorMessage = passwordText.isEmpty ? String.Field.emptyPassword : String.Field.invalidPassword
        }
      }
      .store(in: &cancellables)
    
    $newPassword
      .removeDuplicates()
      .dropFirst()
      .sink { [weak self] passwordText in
        guard let self else { return }
        isValidNewPassword = passwordText.isValidPassword
        if newPassword != passwordText && !repeatPassword.isEmpty {
          repeatPassword = ""
        }
        if !isValidNewPassword {
          newPasswordErrorMessage = passwordText.isEmpty ? String.Field.emptyPassword : String.Field.invalidPassword
        }
      }
      .store(in: &cancellables)
    
    $repeatPassword
      .removeDuplicates()
      .dropFirst()
      .sink { [weak self] repeatPasswordText in
        guard let self else { return }
        isSamePasswords = newPassword == repeatPasswordText
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
  
  func changePassword(completion: @escaping () -> Void ) {
      isLoading = true
      isShowMessage = false
      changePasswordRepository.changePassword(oldPassword: oldPassword, newPassword: newPassword)
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
          let isChanged = data.changePassword
          if isChanged {
            showToast(message: String.Toast.changePassword, isSuccess: true)
            completion()
          }
        }
        .store(in: &cancellables)
  }
  
}
