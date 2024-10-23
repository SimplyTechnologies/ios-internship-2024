//
//  ProfileView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

struct ProfileScreen: View {

  var body: some View {
    ZStack {
      Color.lightPink
        .ignoresSafeArea()
      VStack(spacing: 50) {
        logo
          .padding(.horizontal, 24)
        userDetails //The view with image, name, and gmail
        buttons //The view with buttons
        Spacer()
      }
    }
  }

}

extension ProfileScreen {

  private var logo: some View {
    HStack {
      Spacer()
      Image(.birth)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 88, height: 40)
    }
  }

  private var userDetails: some View {
    VStack(spacing: 30) {
      Image(.nk)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 100, height: 100)
      VStack(spacing: 15) {
        Text("Shirley Peter")
          .bold()
          .font(.system(size: 20))
        Text(verbatim: "ShirleyPeter01@gmail.com")
          .textSelection(.disabled)
          .foregroundStyle(.black)
          .font(.system(size: 20))
          .frame(maxWidth: .infinity)
          .bold()
      }
    }
  }

  private var buttons: some View {
    VStack(spacing: 11) {
      ProfileButton(
        title: String.Button.editAccount,
        action: {
          print("Edit Account") // Navigation to Edit Account screen
        })
      ProfileButton(
        title: String.Button.changePassword,
        action: {
          print("Change Password") // Navigation to Change Password screen
        })
      ProfileButton(
        title: String.Button.signOut,
        action: {
          print("Sign Out") // Navigation to Sign Out screen
        })
    }
    .padding(.horizontal, 16)
  }

}

struct ProfileButton: View { //This struct should be in Models Group

  let title: String
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      HStack {
        Text(title)
          .foregroundStyle(.darkRed)
          .bold()
          .font(.system(size: 20))
          .background(.white)
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 16)
      .padding(.vertical, 12)
      .background(Color.white)
      .cornerRadius(9)
    }
  }

}

#Preview {
  ProfileScreen()
}
