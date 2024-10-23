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
  
}


extension String{
    
    func isEmailValid() -> Bool{
        guard !self.isEmpty else {
            return false
        }
        let emailFormat = "[a-zA-Z0-9.-_]+@[a-zA-Z0-9.-_]+\\.[a-zA-z]{2,60}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    func isPassValid() -> Bool{
        guard !self.isEmpty  else {
            return false
        }
        return self.count > 8
    }
    
}
