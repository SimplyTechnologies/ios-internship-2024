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
        HStack {
          Spacer()
          Image(.birth)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 88, height: 40)
        }
        .padding(.horizontal, 24)
        ProfileDetails() //The view with image, name, and gmail
        ProfileButtons() //The view with buttons
        Spacer()
      }
    }
  }

}

struct ProfileDetails: View {

  var body: some View {
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

}

struct ProfileButtons: View {
  var body: some View {
    VStack(spacing: 11) {
      Button {
        print("Edit Account") //Navigation to Edit Accout screen
      } label: {
        HStack {
          Text(String.Button.editAccount)
            .foregroundStyle(.darkRed)
            .bold()
            .background(.white)
            .font(.system(size: 20))
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(9)
      }
      Button {
        print("Change Password") //Navigation to Change Password screen
      } label: {
        HStack {
          Text(String.Button.changePassword)
            .foregroundStyle(.darkRed)
            .bold()
            .background(.white)
            .font(.system(size: 20))
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(9)
      }
      Button {
        print("Sign Out") //Navigation to Sign Out screen
      } label: {
        HStack {
          Text(String.Button.signOut)
            .foregroundStyle(.darkRed)
            .bold()
            .background(.white)
            .font(.system(size: 20))
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(9)
      }
    }
    .padding(.horizontal, 16)
  }

}

#Preview {
  ProfileScreen()
}
