//
//  ProfileViewModel.swift
//  Birthday
//
//  Created by Anna Hakobyan on 23.10.24.
//

import Foundation
import Combine

final class ProfileViewModel: ProfileViewModeling {

  @Published var isLoading: Bool = false
  @Published var profileData: ProfileModel = ProfileModel(
    email: "",
    firstName: "",
    id: 0,
    image: "",
    lastName: ""
  )

  private var profileRepository: ProfileRepository
  private var cancelables = Set<AnyCancellable>()

  func getProfileData() {
    profileRepository.getProfile()
      .sink { result in
        switch result {
        case .finished:
          print("Succeed!")
        case .failure(let error):
          print(error.localizedDescription)
        }
      } receiveValue: { [weak self] profile in
        self?.profileData = ProfileModel(dto: profile)
      }.store(in: &cancelables)
  }

  init( profileRepository: ProfileRepository) {
    self.profileRepository = profileRepository
  }

}
