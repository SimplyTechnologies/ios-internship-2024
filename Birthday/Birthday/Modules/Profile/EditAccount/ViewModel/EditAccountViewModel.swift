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
  private var cancellables = Set<AnyCancellable>()

  private var editAccountRepository: EditAccountRepository
  
  init(editAccountRepository: EditAccountRepository, initialModel: EditAccountModel) {
    self.editAccountRepository = editAccountRepository
    self.editAccountModel = initialModel
  }
  
  func updateProfileData(model: EditAccountModel) {
    isLoading = true
    
    let input = UpdateProfileInput(
      firstName: model.firstName.isEmpty ? .none : .some(model.firstName),
      image: model.image.isEmpty ? .none : .some(model.image),
      lastName: model.lastName.isEmpty ? .none : .some(model.lastName)
    )
    
    editAccountRepository.updateProfile(input: input)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          print("Update succeeded!")
        case .failure(let error):
          print("Error updating profile: \(error.localizedDescription)")
        }
      }, receiveValue: { [weak self] profile in
        // Update the model with the new profile data
        self?.editAccountModel = EditAccountModel(dto: profile)
      })
      .store(in: &cancellables)
    
  }
  func updateFirstName(_ firstName: String) {
    editAccountModel.firstName = firstName
  }
  
  // Method to update last name from the UI
  func updateLastName(_ lastName: String) {
    editAccountModel.lastName = lastName
  }
  
  // Method to update image from the UI
  func updateImage(_ image: String?) {
    editAccountModel.image = image ?? ""
  }
}
