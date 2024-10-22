//
//  SignInViewModel.swift
//  Birthday
//
//  Created by Sona on 21.10.24.
//
import SwiftUI
import Combine

class SignInViewModel: ObservableObject{
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var emailErrorText:String = ""
    @Published var passErrorText:String = ""
    
    @Published var buttonDisabledState:Bool = false
    
    func checkEmail(){
        guard !email.isEmpty else {
            emailErrorText = ""
            return
        }
        let emailFormat = "[a-zA-Z0-9.-_]+@[a-zA-Z0-9.-_]+\\.[a-zA-z]{2,60}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        emailErrorText = emailPredicate.evaluate(with: email) ? "" : "email_error_text".localized
        setButton()
    }
    
    func checkPassword(){
        guard !password.isEmpty  else {
            passErrorText = ""
            return
        }
        passErrorText = password.count > 8 ? "" : "password_error_text".localized
        setButton()
    }
    
    func setButton() {
        buttonDisabledState = !(email.isEmpty || password.isEmpty || !emailErrorText.isEmpty || !passErrorText.isEmpty)
    }
    
}
