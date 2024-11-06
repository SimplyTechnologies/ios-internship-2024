//
//  ResetPasswordViewModeling.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 30.10.24.
//

import Foundation

protocol ResetPasswordViewModeling: ObservableObject {
  
  var id: UUID { get }
  var isLoading: Bool { get set }
  var password: String { get set }
  var confirmPassword: String { get set }
  var isPasswordValid: Bool { get set }
  var isConfirmPassValid: Bool { get set }
  var isShowMessage: Bool { get set }
  var isSuccessMessage: Bool { get set }
  var toastMessage: String { get set }
  var isPasswordFocused: Bool { get set }
  var isRepeatPasswordFocused: Bool { get set }
  var repeatPasswordErrorMessage: String { get set }
  var passwordErrorMessage: String { get set }
  var isSamePasswords: Bool { get set }
  var isShowPasswordField: Bool { get set }
  var isValidForm: Bool { get }

  func changePassword(navigationAction: @escaping () -> ())
  
}
