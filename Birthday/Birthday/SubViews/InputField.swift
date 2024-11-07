//
//  InputField.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

struct InputField: View {
  
  @FocusState private var isTextFieldFocused: Bool
  @State private var isShow: Bool = false
  @Binding var text: String
  @Binding var isFocused: Bool
  @Binding var isValidField: Bool

  private let placeholderText: String
  private let isSecureField: Bool
  private let backgroundColor: Color
    
  init(
    text: Binding<String>,
    isFocused: Binding<Bool>,
    isValidField: Binding<Bool> = .constant(true),
    placeholderText: String = "",
    isSecureField: Bool = false,
    backgroundColor: Color = .lightPink
  ) {
    self._text = text
    self._isFocused = isFocused
    self._isValidField = isValidField
    self.placeholderText = placeholderText
    self.isSecureField = isSecureField
    self.backgroundColor = backgroundColor
  }

  var body: some View {
    HStack(spacing: 0) {
      if isSecureField && !isShow {
        secureTextField
      } else {
        textField
      }
      if isSecureField {
        hideButton
          .padding(.leading, 8)
      }
    }
    .padding(.horizontal, 16)
    .frame(height: 44)
    .background(!isValidField ? Color.piggyPink : backgroundColor)
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .background(
      ZStack {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
          .stroke(!isValidField ? Color.red : isTextFieldFocused ? Color.rouge : Color.clear, lineWidth: 1)
      }
    )
  }

  var textField: some View {
    TextField("", text: $text)
      .onChange(of: isFocused) { newValue in
        isTextFieldFocused = newValue ? true : false
      }
      .onChange(of: isTextFieldFocused) { value in
        isFocused = value
      }
      .focused($isTextFieldFocused)
      .placeholder(when: text.isEmpty) {
        Text(placeholderText)
          .foregroundStyle(Color.rouge.opacity(0.74))
          .karmaFont(style: .regular14)
          .padding(.bottom, 4)
      }
      .foregroundStyle(Color.rouge)
      .tint(Color.rouge)
      .karmaFont(style: .bold14)
      .autocorrectionDisabled()
      .textInputAutocapitalization(.never)
  }

  var secureTextField: some View {
    SecureField("", text: $text)
      .onChange(of: isFocused) { newValue in
        isTextFieldFocused = newValue ? true : false
      }
      .onChange(of: isTextFieldFocused) { value in
        isFocused = value
      }
      .focused($isTextFieldFocused)
      .placeholder(when: text.isEmpty) {
        Text(placeholderText)
          .foregroundStyle(Color.rouge.opacity(0.74))
          .karmaFont(style: .regular14)
          .padding(.bottom, 4)
      }
      .foregroundStyle(Color.rouge)
      .tint(Color.rouge)
      .karmaFont(style: .bold14)
      .autocorrectionDisabled()
      .textInputAutocapitalization(.never)
  }

  var hideButton: some View {
    Button {
      isShow.toggle()
    } label: {
      if isShow {
        Image(.hide)
          .resizable()
          .frame(width: 15, height: 15)
      } else {
        Image(.show)
          .resizable()
          .frame(width: 15, height: 12)
      }
    }
  }
  
}

#Preview {
  InputField(
    text: .constant(""),
    isFocused: .constant(false),
    isValidField: .constant(true),
    placeholderText: "Input",
    isSecureField: true,
    backgroundColor: .white
  )
  .padding()
}
