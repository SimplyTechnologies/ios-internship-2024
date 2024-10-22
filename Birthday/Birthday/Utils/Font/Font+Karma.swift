//
//  Font+Karma.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

enum KarmaFontStyle: String {
  
  case regular = "Karma-Regular"
  case medium = "Karma-Medium"
  case bold = "Karma-Bold"
  case semiBold = "Karma-SemiBold"
  case light = "Karma-Light"
  
}

extension Font {
  
  static func karmaFont(style: KarmaFontStyle, size: CGFloat) -> Self {
    .custom(style.rawValue, size: size)
  }

  static func karmaFont(style: CustomFontStyle) -> Self {
    style.karmaFont
  }
  
}

struct KarmaFontModifier: ViewModifier {
  
  let style: KarmaFontStyle = .regular
  var size: CGFloat

  func body(content: Content) -> some View {
    content
      .font(Font.custom(style.rawValue, size: size))
  }
  
}

extension View {
  
  func karmaFont(size: CGFloat) -> some View {
    modifier(KarmaFontModifier(size: size))
      .dynamicTypeSize(.xLarge)
  }

  func karmaFont(style: CustomFontStyle) -> some View {
    modifier(CustomFontModifier(style: style))
      .dynamicTypeSize(.xLarge)
  }
  
}

struct CustomFontModifier: ViewModifier {
  
  var style: CustomFontStyle = .bold26

  func body(content: Content) -> some View {
    content.font(Font.karmaFont(style: style))
  }
  
}

extension UIFont {
  
  static func karmaFont(style: KarmaFontStyle, size: CGFloat) -> UIFont {
    UIFont(name: style.rawValue, size: size) ?? .systemFont(ofSize: 15, weight: .regular)
  }

  static func karmaFont(style: CustomFontStyle) -> UIFont {
    style.karmaUIFont
  }
  
}

enum CustomFontStyle {
  
  case regular16, regular14, regular12, regular10
  case medium16, medium14, medium12, medium10
  case bold30, bold26, bold22, bold16, bold14, bold12, bold10
  case semiBold16, semiBold14, semiBold12
  case light16, light14, light12

  var karmaFont: Font {
    switch self {
    case .regular16: .custom(KarmaFontStyle.regular.rawValue, size: 16)
    case .regular14: .custom(KarmaFontStyle.regular.rawValue, size: 14)
    case .regular12: .custom(KarmaFontStyle.regular.rawValue, size: 12)
    case .regular10: .custom(KarmaFontStyle.regular.rawValue, size: 10)
    case .medium16: .custom(KarmaFontStyle.medium.rawValue, size: 16)
    case .medium14: .custom(KarmaFontStyle.medium.rawValue, size: 14)
    case .medium12: .custom(KarmaFontStyle.medium.rawValue, size: 12)
    case .medium10: .custom(KarmaFontStyle.medium.rawValue, size: 10)
    case .bold30: .custom(KarmaFontStyle.bold.rawValue, size: 30)
    case .bold26: .custom(KarmaFontStyle.bold.rawValue, size: 26)
    case .bold22: .custom(KarmaFontStyle.bold.rawValue, size: 22)
    case .bold16: .custom(KarmaFontStyle.bold.rawValue, size: 16)
    case .bold14: .custom(KarmaFontStyle.bold.rawValue, size: 14)
    case .bold12: .custom(KarmaFontStyle.bold.rawValue, size: 12)
    case .bold10: .custom(KarmaFontStyle.bold.rawValue, size: 10)
    case .semiBold16: .custom(KarmaFontStyle.semiBold.rawValue, size: 16)
    case .semiBold14: .custom(KarmaFontStyle.semiBold.rawValue, size: 14)
    case .semiBold12: .custom(KarmaFontStyle.semiBold.rawValue, size: 12)
    case .light16: .custom(KarmaFontStyle.light.rawValue, size: 26)
    case .light14: .custom(KarmaFontStyle.light.rawValue, size: 20)
    case .light12: .custom(KarmaFontStyle.light.rawValue, size: 16)
    }
  }

  var karmaUIFont: UIFont {
    switch self {
    case .bold26: UIFont(name: KarmaFontStyle.bold.rawValue, size: 26) ?? .systemFont(ofSize: 26)
    default:
      UIFont(name: KarmaFontStyle.bold.rawValue, size: 26) ?? .systemFont(ofSize: 26)
    }
  }
  
}
