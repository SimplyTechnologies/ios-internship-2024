//
//  EditAccountView.swift
//  Birthday
//
//  Created by Anna Hakobyan on 24.10.24.
//

import SwiftUI

struct EditAccountView: View {
  
  @State private var name = ""
  @State private var surname = ""
  
  var body: some View {
    VStack(spacing: 43) {
      logo
      image
      VStack(spacing: 7) {
        InputField(label: "Name", text: $name, placeholder: "Enter your name")
        InputField(label: "Surname", text: $surname, placeholder: "Enter your surname")
      }
      Spacer()
      buttonDone
    }
    .background(Color.lightPink)
  }
}

extension EditAccountView {

  private var logo: some View {
    Image(.birth)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: 88, height: 40)
  }
  
  private var image: some View {
    ZStack {
      Circle()
        .stroke(.darkRed, lineWidth: 2)
        .frame(width: 160, height: 160)
      Image(.nk)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .clipShape(Circle())
        .frame(width: 150, height: 150)
    }
  }
  
  private var buttonDone: some View {
    Button(action: {
      //TODO: Save the changes
    }) {
      Text("Done")
        .foregroundColor(.white)
        .padding()
        .background(name.isEmpty || surname.isEmpty ? Color.mainPink : Color.darkRed)
        .cornerRadius(8)
    }
    .disabled(name.isEmpty || surname.isEmpty) // Disable button if fields are empty
    .padding()
  }
}

struct InputField: View {
  let label: String
  @Binding var text: String
  let placeholder: String
  
  var body: some View {
    VStack {
      HStack {
        Text(label)
          .font(.system(size: 18))
          .foregroundStyle(.darkRed70)
          .multilineTextAlignment(.leading)
        Spacer()
      }
      HStack(spacing: 18) {
        Spacer()
        TextField(placeholder, text: $text)
      }
      .frame(height: 41)
      .background(.white)
      .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    .padding(.horizontal, 61)
  }
}

#Preview {
  EditAccountView()
}
