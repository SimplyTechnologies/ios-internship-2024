//
//  ForgotPasswordViewModeling.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 29.10.24.
//

import Foundation

protocol ForgotPasswordViewModeling: Toastable {
  
  var isLoading: Bool { get set }
  var email: String { get set }
  var passwordCode: String { get set }
  var isCodeValid: Bool { get set }
  var isEmailValid: Bool { get set }
  var actualCode: String { get set }
  var isShowMessage: Bool { get set }
  var isSuccessMessage: Bool { get set }
  var toastMessage: String { get set }
  var emailErrorMessage: String { get set }
  var codeErrorMessage: String { get set }
  var isEmailFocused: Bool { get set }
  var isCodeFocused: Bool { get set }
  var isGetCodeDisabled: Bool { get }
  var isSetPasswordDisabled: Bool { get }
  
  func getCode()
  func checkCode(complition: @escaping () -> ())
  
}
