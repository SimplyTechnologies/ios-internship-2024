//
//  Texts.swift
//  Birthday
//
//  Created by Narek on 21.10.24.
//

import Foundation

extension String {
  
  enum Button {
    static var login: String { "button_login".localized }
    static var signIn: String { "button_signIn".localized }
    static var register: String { "button_register".localized }
  }
  
  enum TextField {
    static var email: String { "email_text".localized }
    static var password: String { "password_text".localized }
  }
  
  enum Label {
    static var emailErrorText: String { "email_text".localized }
    static var passErrorText: String { "password_error_text".localized }
  }
  
  func toFormattedDate() -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    guard let date = inputFormatter.date(from: self) else {
      return nil
    }
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "dd.MM.yyyy"
    
    return outputFormatter.string(from: date)
  }
  
}
