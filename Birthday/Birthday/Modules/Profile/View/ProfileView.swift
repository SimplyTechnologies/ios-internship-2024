//
//  ProfileView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

struct ProfileView<T: ProfileViewModeling>: View {
  
  @ObservedObject var viewModel: T
  
  var body: some View {
    VStack(spacing: 50) {
      logo
      userDetails //image, name, gmail
      buttons
      Spacer()
    }
    .background(Color.lightPink)
    .onLoad {
      viewModel.getProfileData()
    }
  }
}

extension ProfileView {
  
  private var logo: some View {
    Image(.birth)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: 88, height: 40)
  }
  
  private var userDetails: some View {
    VStack(spacing: 30) {
      AsyncImage(url: URL(string: viewModel.profileData.image ?? "")) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
          .clipShape(Circle())
      } placeholder: {
        // TODO: Placeholder view
        ZStack {
          Circle()
            .stroke(.darkRed, lineWidth: 2)
            .frame(width: 100, height: 100)
          Image(.imagePlus)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 42, height: 42)
        }
      }
      .frame(width: 100, height: 100)
      VStack(spacing: 15) {
        Text(viewModel.profileData.fullname ?? "")
          .bold()
          .font(.system(size: 20))
        Text(verbatim: viewModel.profileData.email ?? "")
          .textSelection(.disabled)
          .foregroundStyle(.black)
          .font(.system(size: 20))
          .frame(maxWidth: .infinity)
          .bold()
      }
    }
  }
  
  private var buttons: some View {
    NavigationStack {
      VStack(spacing: 11) {
        // Navigation to EditAccountView
        //        NavigationLink(destination: EditAccountView(
        //          viewModel: EditAccountViewModel(
        //            editAccountRepository: EditAccountDefaultRepository(),
        //            model: EditAccountModel(
        //              firstName: viewModel.profileData.firstName,
        //              image: viewModel.profileData.image ?? "",
        //              lastName: viewModel.profileData.lastName)),
        ////          model: $viewModel.profileData,
        //          doneAction: { data in
        //            viewModel.profileData.firstName = data.firstName
        //            viewModel.profileData.lastName = data.lastName
        //            viewModel.profileData.image = data.image
        //          })) {
        //            ProfileButton(title: String.Button.editAccount)
        //          }
        
        NavigationLink {
          // destin
          EditAccountView<EditAccountViewModel>(
            viewModel: EditAccountViewModel(
              editAccountRepository: EditAccountDefaultRepository(),
              model: .init(
                firstName: viewModel.profileData.firstName,
                image: viewModel.profileData.image ?? "",
                lastName: viewModel.profileData.lastName
              )
            ),
            model: .init(
              firstName: viewModel.profileData.firstName,
              image: viewModel.profileData.image ?? "",
              lastName: viewModel.profileData.lastName
            )) { profileModel in
//            // Done action
            viewModel.profileData.firstName = profileModel.firstName
            viewModel.profileData.lastName = profileModel.lastName
            viewModel.profileData.image = profileModel.image
          }
        } label: {
          ProfileButton(title: String.Button.editAccount)
        }
        
        // TODO: Add other buttons
      }
      .padding(.horizontal, 16)
    }
  }
}

struct ProfileButton: View {
  
  var title: String
  
  var body: some View {
    Text(title)
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 16)
      .padding(.vertical, 12)
      .background(Color.white)
      .cornerRadius(9)
      .foregroundStyle(.darkRed)
      .bold()
      .font(.system(size: 20))
  }
  
}
