//
//  Date+Extension.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 24.10.24.
//

import Foundation

extension DateFormatter {
  
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
  }()
  
}

extension Date {
  
  func toISO8601String() -> String {
    return DateFormatter.iso8601Full.string(from: self)
  }
  
}
