//
//  ProfileViewModel.swift
//  Birthday
//
//  Created by Anna Hakobyan on 23.10.24.
//

import BirthDayAPI
import Combine
import Foundation
import PhotosUI
import SwiftUI

final class EditAccountViewModel: EditAccountViewModeling {
  
  @Published var isLoading: Bool = false
  @Published var editAccountModel: EditAccountModel
  @Published var profileModel: ProfileModel = .init(firstName: "", lastName: "")
  @Published var isNameFocused: Bool = false
  @Published var isSurnameFocused: Bool = false
  @Published var selectedImage: UIImage? = nil
  @Published var isShowMessage: Bool = false
  @Published var isPickerPresented = false
  @Published var isShowPickerOptions = false
  @Published var selectedSourceType: UIImagePickerController.SourceType = .photoLibrary
  
  
  var toastMessage: String = ""
  var isSuccessMessage: Bool = false
  
  private var cancellables = Set<AnyCancellable>()
  private var editAccountRepository: EditAccountRepository
  
  var isDisabled: Bool {
    let isSameFirstName = editAccountModel.firstName == profileModel.firstName
    let isSameLastName = editAccountModel.lastName == profileModel.lastName
    let isSameImage = editAccountModel.image == profileModel.image
    let isSameData = isSameFirstName && isSameLastName && isSameImage
    
    let isFirstNameEmpty = profileModel.firstName.isEmpty
    let isLastNameEmpty = profileModel.lastName.isEmpty
    
    return isSameData || isFirstNameEmpty || isLastNameEmpty
  }
  
  
  let id: UUID = UUID()
  
  init(editAccountRepository: EditAccountRepository, model: EditAccountModel) {
    self.editAccountRepository = editAccountRepository
    self.editAccountModel = model
    
    $selectedImage
      .sink { [weak self] image in
        guard let self, let image else { return }
        image.convertToBase64(size: .init(width: 160, height: 160)) { [weak self] error, base64String in
          guard let self else { return }
          profileModel.image = base64String
        }
      }
      .store(in: &cancellables)
  }
  
  func updateProfileData(completion: @escaping () -> Void) {
    isLoading = true
    isShowMessage = false
    let isSameImage = editAccountModel.image == profileModel.image
    let image = !editAccountModel.image.isEmpty && isSameImage ? nil : profileModel.image
    
    let input = UpdateProfileInput(
      firstName: profileModel.firstName.isEmpty ? nil : .some(profileModel.firstName),
      image: image.isNil ? nil : .some(image ?? ""),
      lastName: profileModel.lastName.isEmpty ? nil : .some(profileModel.lastName)
    )
    
    editAccountRepository.updateProfile(input: input)
      .sink(receiveCompletion: { [weak self] result in
        guard let self else { return }
        isLoading = false
        switch result {
        case .finished:
          Console.log("Update Profile succeeded!")
        case .failure(let error):
          Console.log("Error updating profile: \(error.localizedDescription)")
          showToast(message: error.localizedDescription, isSuccess: false)
        }
      }, receiveValue: { [weak self] profile in
        guard let self else { return }
        profileModel.lastName = profile.updateProfile.lastName
        profileModel.firstName = profile.updateProfile.firstName
        profileModel.image = profile.updateProfile.image
        showToast(message: String.Toast.editProfile, isSuccess: true)
        completion()
      })
      .store(in: &cancellables)
  }
  
}
