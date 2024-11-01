//
//  UIAplication.swift
//  Birthday
//
//  Created by Anna Hakobyan on 01.11.24.
//

import SwiftUI

extension UIApplication {
  func hideKeyboard() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
