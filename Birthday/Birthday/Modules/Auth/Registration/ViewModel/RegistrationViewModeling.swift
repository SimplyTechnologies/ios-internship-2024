//
//  RegistrationViewModeling.swift
//  Birthday
//
//  Created by Narek on 29.10.24.
//

import Foundation

protocol RegistrationViewModeling: Toastable {
  
  var id: UUID { get }
  var isLoading: Bool { get set }
  var name: String { get set }
  var surname: String { get set }
  var email: String { get set }
  var password: String { get set }
  var repeatPassword: String { get set }
  var isNameFocused: Bool { get set }
  var isSurnameFocused: Bool { get set }
  var isEmailFocused: Bool { get set }
  var isPasswordFocused: Bool { get set }
  var isRepeatPasswordFocused: Bool { get set }
  var isValidName: Bool { get set }
  var isValidSurname: Bool { get set }
  var isValidEmail: Bool { get set }
  var isValidPassword: Bool { get set }
  var isValidRepeatPassword: Bool { get set }
  var isValidForm: Bool { get }
  var isSamePasswords: Bool { get set }
  var isShowPasswordField: Bool { get set }
  var repeatPasswordErrorMessage: String { get set }
  var passwordErrorMessage: String { get set }
  var nameErrorMessage: String { get set }
  var surnameErrorMessage: String { get set }
  var emailErrorMessage: String { get set }
  
  func register(completion: @escaping () -> Void)
  
}
