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
  
  var toDate: Date? {
    DateFormatter.iso8601Full.date(from: self)
  }
  
  func convertToISODate() -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "dd.MM.yyyy"
    guard let date = inputFormatter.date(from: self) else {
      return nil
    }
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    outputFormatter.timeZone = TimeZone(abbreviation: "UTC")
    return outputFormatter.string(from: date)
  }
  
}
