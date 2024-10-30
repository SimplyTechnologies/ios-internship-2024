//
//  ResetPasswordViewModeling.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 30.10.24.
//

import Foundation

protocol ResetPasswordViewModeling: ObservableObject {
  
  var isLoading: Bool { get set }
  var password: String { get set }
  var confirmPassword: String { get set }
  var isPasswordValid: Bool { get set }
  var isConfirmPassValid: Bool { get set }
  
  func changePassword(navigationAction: @escaping () -> ())
  
}
