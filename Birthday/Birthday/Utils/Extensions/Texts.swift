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
