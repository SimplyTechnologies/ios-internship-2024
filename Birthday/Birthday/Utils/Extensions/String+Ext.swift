//
//  String+Ext.swift
//  Birthday
//
//  Created by Narek on 21.10.24.
//

import Foundation

extension String {
  
  var localized: String {
    NSLocalizedString(self, comment: "")
  }

  var isValidEmail: Bool {
    let emailRegEx =  #"[a-zA-Z0-9+._%\-+]{1,256}[a-zA-Z0-9]@[a-zA-Z0-9][a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+"#
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return self.count <= 60 && emailPredicate.evaluate(with: self)
  }
  
  var isValidName: Bool {
    let nameRegEx = "^[A-Za-z]{1,20}$"
    let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
    return namePredicate.evaluate(with: self)
  }
  
  var isValidPassword: Bool {
    let passwordRegEx = "^(?=.*[a-z])(?=.*[!\"#$%&'()*+,-./:;<=>?@^_`{|}~])[A-Za-z\\d!\"#$%&'()*+,-./:;<=>?@^_`{|}~]{8,20}"
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
    return passwordPredicate.evaluate(with: self)
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

extension String {
  
  enum Button {
    
    static var login: String { "button_login".localized }
    static var register: String { "button_register".localized }
    
  }
  
  enum Field {
    
    static var name: String { "field_name".localized }
    static var surname: String { "field_surname".localized }
    static var email: String { "field_email".localized }
    static var password: String { "field_password".localized }
    static var repeatPassword: String { "field_repeat_password".localized }
    static var emptyName: String { "field_empty_name".localized }
    static var invalidName: String { "field_invalid_name".localized }
    static var emptySurname: String { "field_empty_surname".localized }
    static var invalidSurname: String { "field_invalid_surname".localized }
    static var emptyEmail: String { "field_empty_email".localized }
    static var invalidEmail: String { "field_invalid_email".localized }
    static var emptyPassword: String { "field_empty_password".localized }
    static var invalidPassword: String { "field_invalid_password".localized }
    static var emptyRepeatPassword: String { "field_empty_repeat_password".localized }
    static var invalidRepeatPassword: String { "field_invalid_repeat_password".localized }
    
  }
  
}
