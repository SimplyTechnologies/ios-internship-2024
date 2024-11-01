//
//  RoundedButton.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

struct RoundedButton: View {
    
  private let name: String
  private let isLoading: Bool
  private let isSecondary: Bool
  private let action: () -> Void
  
  init(
    name: String,
    isLoading: Bool = false,
    isSecondary: Bool = false,
    action: @escaping () -> Void
  ) {
    self.name = name
    self.isLoading = isLoading
    self.isSecondary = isSecondary
    self.action = action
  }

  var body: some View {
    Button {
      action()
    } label: {
      Text(name)
    }
    .if(!isSecondary) { view in
      view
        .buttonStyle(RoundedButtonStyle(isLoading))
    }
    .if(isSecondary) { view in
      view
        .buttonStyle(SecondaryRoundedButtonStyle(isLoading))
    }
  }
  
}

#Preview {
  RoundedButton(name: "Register", isLoading: true) { }
  .padding()
}
