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
