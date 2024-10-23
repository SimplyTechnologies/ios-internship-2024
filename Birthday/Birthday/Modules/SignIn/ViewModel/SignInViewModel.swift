//
//  SignInViewModel.swift
//  Birthday
//
//  Created by Sona on 21.10.24.
//
import SwiftUI

class SignInViewModel: ObservableObject {
  
  @Published var email: String = ""
  @Published var password: String = ""
  
  @Published var emailErrorText: String = ""
  @Published var passErrorText: String = ""
    
  @Published var buttonDisabledState: Bool = false
    
  func checkEmail() {
    emailErrorText = email.isEmailValid() ? "" : String.Label.emailErrorText
    checkButtonState()
  }
    
  func checkPassword() {
    passErrorText = password.isPassValid() ? "" : String.Label.passErrorText
    checkButtonState()
  }
    
  func checkButtonState() {
    buttonDisabledState = !(email.isEmpty || password.isEmpty || !emailErrorText.isEmpty || !passErrorText.isEmpty)
  }
  
}
