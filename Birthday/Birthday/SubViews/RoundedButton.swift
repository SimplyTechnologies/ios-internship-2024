//
//  RoundedButton.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

struct RoundedButton: View {
    
  let name: String
  var isLoading: Bool = false
  let action: () -> Void

  var body: some View {
    Button {
      action()
    } label: {
      Text(name)
    }
    .buttonStyle(RoundedButtonStyle(isLoading))
  }
  
}

#Preview {
  RoundedButton(name: "Register", isLoading: true) { }
  .padding()
}
