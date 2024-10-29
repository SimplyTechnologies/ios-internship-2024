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
  
  var toISO8601String: String {
    DateFormatter.iso8601Full.string(from: self)
  }
  
  func getNextOccurrence() -> Date? {
    let calendar = Calendar.current
    let day = calendar.component(.day, from: self)
    let month = calendar.component(.month, from: self)
    let currentYear = calendar.component(.year, from: Date())
    var nextDateComponents = DateComponents(year: currentYear, month: month, day: day)
    if let nextDate = calendar.date(from: nextDateComponents), nextDate >= Date() {
      return nextDate
    } else {
      nextDateComponents.year = currentYear + 1
      return calendar.date(from: nextDateComponents)
    }
  }
  
}
