//
//  ProfileScreen.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

struct ProfileScreen<T: ProfileViewModeling>: View {
  
  @EnvironmentObject var router: NavigationRouter
  @StateObject var viewModel: T
  
  var body: some View {
    VStack(spacing: 50) {
      NavigationBar()
      userDetails
      buttons
      Spacer()
    }
    .background(Color.lightPink)
    .onLoad {
      viewModel.getProfileData()
    }
  }
  
}

extension ProfileScreen {
    
  private var userDetails: some View {
    VStack(spacing: 0) {
        CircularImage(
          imagePath: viewModel.profileData.image ?? "",
          placeholderImage: Image(systemName: "person"),
          size: .init(width: 100, height: 100)
        )
      Spacer()
        .frame(height: 32)
      
        Text(viewModel.profileData.fullname ?? "")
          .foregroundStyle(.black)
          .karmaFont(style: .bold20)
        
        Spacer()
          .frame(height: 16)

        Text(verbatim: viewModel.profileData.email ?? "")
          .foregroundStyle(.black)
          .karmaFont(style: .bold20)
    }
    .padding(.horizontal, 16)
  }
  
  private var buttons: some View {
    VStack(spacing: 10) {
      editButton
    }
    .padding(.horizontal, 16)
  }
  
  private var editButton: some View {
      ProfileButton(
        title: String.Button.editAccount
      ) {
        let editViewModel = EditAccountViewModel(
          editAccountRepository: EditAccountDefaultRepository(),
          model: .init(
            firstName: viewModel.profileData.firstName,
            image: viewModel.profileData.image ?? "",
            lastName: viewModel.profileData.lastName
          )
        )
        
        let profileModel: ProfileModel = .init(
          firstName: viewModel.profileData.firstName,
          image: viewModel.profileData.image ?? "",
          lastName: viewModel.profileData.lastName
        )
        
        let screen = TabBarView.ProfileScreens.editProfile(
          viewModel: editViewModel,
          profileModel: profileModel) {
            viewModel.getProfileData()
          }
        
        router.push(screen)
      }
  }
  
}

#Preview {
  ProfileScreen(viewModel: ProfileViewModel(profileRepository: ProfileDefaultRepository()))
}

