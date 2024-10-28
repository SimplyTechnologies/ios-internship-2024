//
//  ProfileViewModel.swift
//  Birthday
//
//  Created by Anna Hakobyan on 23.10.24.
//

import Foundation
import Combine
import BirthDayAPI

final class EditAccountViewModel: EditAccountViewModeling {
  

  @Published var isLoading: Bool = false
  @Published var editAccountModel: EditAccountModel
  @Published var profileModel: ProfileModel = .init(firstName: "", lastName: "")

  private var cancellables = Set<AnyCancellable>()
  
  private var editAccountRepository: EditAccountRepository
  
  init(editAccountRepository: EditAccountRepository, model: EditAccountModel) {
    self.editAccountRepository = editAccountRepository
    self.editAccountModel = model
  }
  
  func updateProfileData(model: EditAccountModel, completion: @escaping () -> Void) {
    isLoading = true
    
    let input = UpdateProfileInput(
      firstName: model.firstName.isEmpty ? nil : .some(model.firstName),
      image: nil,// model.image.isEmpty ? nil : .some(model.image),
      lastName: model.lastName.isEmpty ? nil : .some(model.lastName)
    )
    
    editAccountRepository.updateProfile(input: input)
      .sink(receiveCompletion: { result in
        switch result {
        case .finished:
          print("Update succeeded!")
        case .failure(let error):
          print("Error updating profile: \(error.localizedDescription)")
        }
      }, receiveValue: { [weak self] profile in
        guard let self else { return }
        profileModel.lastName = profile.updateProfile.lastName
        profileModel.firstName = profile.updateProfile.firstName
        profileModel.image = profile.updateProfile.image
        completion()
//        self?.editAccountModel = EditAccountModel(dto: profile)
      })
      .store(in: &cancellables)
    
  }
  
//  func updateFirstName(_ firstName: String) {
//    editAccountModel.firstName = firstName
//  }
//  
//  // Method to update last name from the UI
//  func updateLastName(_ lastName: String) {
//    editAccountModel.lastName = lastName
//  }
//  
//  // Method to update image from the UI
//  func updateImage(_ image: String?) {
//    editAccountModel.image = image ?? ""
//  }
}
