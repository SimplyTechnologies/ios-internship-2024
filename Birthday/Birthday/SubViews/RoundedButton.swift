//
//  RoundedButton.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

struct RoundedButton: View {
  
  @Environment(\.isEnabled) var isEnabled
  
  let name: String
  let action: () -> Void

  var body: some View {
    Button {
      action()
    } label: {
      Text(name)
    }
    .buttonStyle(RoundedButtonStyle(isEnabled))
  }
  
}

#Preview {
  RoundedButton(name: "Register") { }
  .padding()
}
