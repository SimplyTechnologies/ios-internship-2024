//
//  ChangePasswordViewModeling.swift
//  Birthday
//
//  Created by Narek on 28.10.24.
//

import Foundation

protocol ChangePasswordViewModeling: Toastable {
  
  var id: UUID { get }
  var isLoading: Bool { get set }
  var oldPassword: String { get set }
  var newPassword: String { get set }
  var repeatPassword: String { get set }
  var isOldPasswordFocused: Bool { get set }
  var isNewPasswordFocused: Bool { get set }
  var isRepeatPasswordFocused: Bool { get set }
  var isValidOldPassword: Bool { get set }
  var isValidNewPassword: Bool { get set }
  var isValidRepeatPassword: Bool { get set }
  var isValidForm: Bool { get set }
  var isSamePasswords: Bool { get set }
  var isShowOldPassword: Bool { get set }
  var isShowNewPassword: Bool { get set }
  var isShowRepeatPassword: Bool { get set }
  var oldPasswordErrorMessage: String { get set }
  var newPasswordErrorMessage: String { get set }
  var repeatPasswordErrorMessage: String { get set }
  func changePassword(completion: @escaping () -> Void)
  
}
