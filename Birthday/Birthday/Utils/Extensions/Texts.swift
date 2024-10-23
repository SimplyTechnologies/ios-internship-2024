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
    static var editAccount: String { "button_edit_account".localized }
    static var changePassword: String { "button_change_password".localized }
    static var signOut: String { "button_sign_out".localized }
    static var signIn: String { "button_signin".localized }
    static var register: String { "button_register".localized }
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
