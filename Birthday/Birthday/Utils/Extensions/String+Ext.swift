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
  
  func toDate() -> Date? {
    return DateFormatter.iso8601Full.date(from: self)
  }
  
  func zodiacSign() -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    
    guard let date = formatter.date(from: self) else {
      return nil
    }
    
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day, .month], from: date)
    
    guard let day = components.day, let month = components.month else {
      return nil
    }
    
    switch (month, day) {
    case (1, 20...31), (2, 1...18):
      return "Aquarius"
    case (2, 19...29), (3, 1...20):
      return "Pisces"
    case (3, 21...31), (4, 1...19):
      return "Aries"
    case (4, 20...30), (5, 1...20):
      return "Taurus"
    case (5, 21...31), (6, 1...20):
      return "Gemini"
    case (6, 21...30), (7, 1...22):
      return "Cancer"
    case (7, 23...31), (8, 1...22):
      return "Leo"
    case (8, 23...31), (9, 1...22):
      return "Virgo"
    case (9, 23...30), (10, 1...22):
      return "Libra"
    case (10, 23...31), (11, 1...21):
      return "Scorpio"
    case (11, 22...30), (12, 1...21):
      return "Sagittarius"
    case (12, 22...31), (1, 1...19):
      return "Capricorn"
    default:
      return nil
    }
  }
  
  
}
