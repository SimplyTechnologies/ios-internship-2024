//
//  View.swift
//  Birthday
//
//  Created by Anna Hakobyan on 01.11.24.
//

import SwiftUI

extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
