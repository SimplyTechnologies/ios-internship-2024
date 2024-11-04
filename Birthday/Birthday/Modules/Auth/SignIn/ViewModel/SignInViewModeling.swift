//
//  SignInViewModeling.swift
//  Birthday
//
//  Created by Narek on 28.10.24.
//

import Foundation

protocol SignInViewModeling: Toastable {
  
  var id: UUID { get }
  var isLoading: Bool { get set }
  var email: String { get set }
  var password: String { get set }
  var isEmailFocused: Bool { get set }
  var isPasswordFocused: Bool { get set }
  var isValidEmail: Bool { get set }
  var isValidPassword: Bool { get set }
  var isValidForm: Bool { get set }
  var isShowPasswordField: Bool { get set }
  var passwordErrorMessage: String { get set }
  var emailErrorMessage: String { get set }
  
  func signIn(completion: @escaping () -> Void)
  
}
