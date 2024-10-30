//
//  ProfileViewModel.swift
//  Birthday
//
//  Created by Anna Hakobyan on 23.10.24.
//

import Foundation
import Combine

final class ProfileViewModel: ProfileViewModeling {
  
  var id: UUID
  @Published var isLoading: Bool = false
  
  @Published var profileData: ProfileModel = ProfileModel()
  
  private var profileRepository: ProfileRepository
  private var cancelables = Set<AnyCancellable>()
  
  init(profileRepository: ProfileRepository) {
    self.profileRepository = profileRepository
    self.id = UUID()
  }
  
  func getProfileData() {
    isLoading = true
    profileRepository.getProfile()
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .finished:
          Console.log("Profile data fetching Succeed!")
        case .failure(let error):
          Console.log(error.localizedDescription)
        }
      } receiveValue: { [weak self] profile in
        self?.profileData = ProfileModel(dto: profile)
      }.store(in: &cancelables)
  }

}
