//
//  ZodiacSign.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 24.10.24.
//

import Foundation

enum ZodiacSign: String {
  
  case aquarius = "Aquarius"
  case pisces = "Pisces"
  case aries = "Aries"
  case taurus = "Taurus"
  case gemini = "Gemini"
  case cancer = "Cancer"
  case leo = "Leo"
  case virgo = "Virgo"
  case libra = "Libra"
  case scorpio = "Scorpio"
  case sagittarius = "Sagittarius"
  case capricorn = "Capricorn"
  
  static func from(dateString: String) -> ZodiacSign? {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    guard let date = formatter.date(from: dateString) else {
      return nil
    }
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day, .month], from: date)
    guard let day = components.day, let month = components.month else {
      return nil
    }
    switch (month, day) {
    case (1, 20...31), (2, 1...18):
      return .aquarius
    case (2, 19...29), (3, 1...20):
      return .pisces
    case (3, 21...31), (4, 1...19):
      return .aries
    case (4, 20...30), (5, 1...20):
      return .taurus
    case (5, 21...31), (6, 1...20):
      return .gemini
    case (6, 21...30), (7, 1...22):
      return .cancer
    case (7, 23...31), (8, 1...22):
      return .leo
    case (8, 23...31), (9, 1...22):
      return .virgo
    case (9, 23...30), (10, 1...22):
      return .libra
    case (10, 23...31), (11, 1...21):
      return .scorpio
    case (11, 22...30), (12, 1...21):
      return .sagittarius
    case (12, 22...31), (1, 1...19):
      return .capricorn
    default:
      return nil
    }
  }
  
}
