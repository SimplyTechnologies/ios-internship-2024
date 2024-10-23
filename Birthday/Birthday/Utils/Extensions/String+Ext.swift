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

}
