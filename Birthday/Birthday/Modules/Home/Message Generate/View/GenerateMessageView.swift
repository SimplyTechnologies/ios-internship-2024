//
//  GenerateMessageView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 25.10.24.
//

import SwiftUI

struct GenerateMessageView: View {
  
  @State private var isSharePresented = false
  @State private var message: String = ""
  @Binding var isPresented: Bool
  
  var body: some View {
    VStack(alignment: .trailing, spacing: 4) {
      TextField("",text: $message, axis: .vertical)
        .placeholder(
          when: message.isEmpty,
          placeholder: {
            Text(String.Field.generate)
              .foregroundStyle(Color.rouge.opacity(0.7))
              .karmaFont(style: .regular14)
              .padding(.bottom, 4)
          }
        )
        .lineLimit(5...)
        .padding(10)
        .scrollContentBackground(.hidden)
        .foregroundStyle(Color.rouge)
        .tint(Color.rouge)
        .karmaFont(style: .bold14)
        .background(Color.lightPink)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.top, 16)
      
      Button {
        withAnimation {
          isSharePresented = true
        }
      } label: {
        Text(String.Birthday.send)
          .foregroundStyle(Color.rouge)
          .padding(6)
          .background(Color.lightPink)
          .clipShape(RoundedRectangle(cornerRadius: 8))
          .padding(.bottom, 8)
      }
    }
    .frame(width: 300, height: 200)
    .padding(.horizontal, 16)
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .shadow(radius: 10)
    .transition(.scale)
    .sheet(isPresented: $isSharePresented) {
      ShareSheet(message: $message) { completed in
        if completed {
          isPresented = false
        }
        withAnimation {
          isSharePresented = false
        }
      }
    }
  }
  
}

#Preview {
  GenerateMessageView(
    isPresented: .constant(true)
  )
}
