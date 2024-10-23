//
//  ValidationTextField.swift
//  Birthday
//
//  Created by Sona on 22.10.24.
//

import SwiftUI

struct ValidationTextField: View {
  
  @Binding private var inputText: String
  @Binding private var isPasswordHidden: Bool

  private let placeholder: String
  private let errorText: String
  private let isSecure: Bool

  init(
    placeholder: String,
    inputText: Binding<String>,
    errorText: String = "",
    isPasswordHidden: Binding<Bool>,
    isSecure: Bool = false
  ) {
    self.placeholder = placeholder
    self._inputText = inputText
    self.errorText = errorText
    self._isPasswordHidden = isPasswordHidden
    self.isSecure = isSecure
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 3) {
      ZStack(alignment: .trailing) {
        VStack {
          if !(isPasswordHidden && isSecure) {
            TextField(placeholder, text: $inputText)
          } else {
            SecureField(placeholder, text: $inputText)
          }
        }
        .placeholder(when: inputText.isEmpty) {
          Text(placeholder)
        }
        .textFieldStyle()

        if isSecure {
          Button(action: { isPasswordHidden.toggle() }) {
            Image(isPasswordHidden ? "show.password" : "hide.password")
              .frame(width: 15, height: 15)
          }
          .padding(.trailing, 12)
        }
      }
      .background(.lightPink)
      .cornerRadius(13)

      if !errorText.isEmpty {
        Text(errorText)
          .errorTextStyle()
          .frame(height: 30, alignment: .leading)
          .offset(x: 5)
      }
    }
  }
}

#Preview {
  ValidationTextField(placeholder: "", inputText: .constant(""), isPasswordHidden: .constant(false))
}
