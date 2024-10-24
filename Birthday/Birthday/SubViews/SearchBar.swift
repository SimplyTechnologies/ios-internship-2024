//
//  SearchBar.swift
//  Birthday
//
//  Created by Narek on 24.10.24.
//

import Combine
import SwiftUI

struct SearchBar: View {
  
  @FocusState var isTextFieldFocused: Bool
  @Binding var searchText: String
  @Binding var isFocused: Bool

  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        Spacer()
        HStack(spacing: 0) {
          Spacer().frame(width: 8)
          textField
          if !searchText.isEmpty {
            clearButton
          } else {
            searchIcon
          }
        }
        .padding(.horizontal, 16)
        Spacer()
      }
      .frame(height: 40)
    }
    .background(Color.white)
    .clipShape(Capsule())
  }

  var textField: some View {
    TextField("", text: $searchText)
      .onChange(of: isFocused, perform: { newValue in
        withAnimation {
          isTextFieldFocused = newValue ? true : false
        }
      })
      .onSubmit {
        withAnimation {
          isTextFieldFocused = false
          isFocused = false
        }
      }
      .focused($isTextFieldFocused)
      .placeholder(when: searchText.isEmpty) {
        Text(String.Field.search)
          .foregroundStyle(Color.spanishGray)
          .karmaFont(style: .bold14)
      }
      .foregroundStyle(Color.black)
      .tint(Color.black)
      .karmaFont(style: .bold14)
      .submitLabel(.search)
  }

  var searchIcon: some View {
    Image(systemName: "magnifyingglass")
      .renderingMode(.template)
      .resizable()
      .frame(width: 16, height: 16)
      .foregroundStyle(isTextFieldFocused ? .black : .spanishGray)
  }

  var clearButton: some View {
    Button {
      searchText = ""
    } label: {
      Image(systemName: "xmark.circle.fill")
        .renderingMode(.template)
        .resizable()
        .frame(width: 16, height: 16)
        .foregroundStyle(Color.black)
    }
  }
  
}

#Preview {
  SearchBar(searchText: .constant("dzc"), isFocused: .constant(false))
}
