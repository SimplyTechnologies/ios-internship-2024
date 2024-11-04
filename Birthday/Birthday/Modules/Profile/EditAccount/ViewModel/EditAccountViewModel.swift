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
  @Published var selectedPickerItem: PhotosPickerItem?
  @Published var selectedImage: UIImage? = nil
  @Published var isShowMessage: Bool = false
  
  var toastMessage: String = ""
  var isSuccessMessage: Bool = false

  private var cancellables = Set<AnyCancellable>()
  private var editAccountRepository: EditAccountRepository
  
  var isDisabled: Bool {
    let isSameFirstName = editAccountModel.firstName == profileModel.firstName
    let isSameLastName = editAccountModel.lastName == profileModel.lastName
    let isSameImage = editAccountModel.image == profileModel.image
    let isSameData = isSameLastName && isSameFirstName && isSameImage
    
    let isFirstNameEmpty = profileModel.firstName.isEmpty
    let isLastNameEmpty = profileModel.lastName.isEmpty
    let isImageEmpty = profileModel.image.isNil
    let isEmptyData = isFirstNameEmpty && isLastNameEmpty && isImageEmpty
    
    return isSameData || isEmptyData
  }
  
  let id: UUID = UUID()
  
  init(editAccountRepository: EditAccountRepository, model: EditAccountModel) {
    self.editAccountRepository = editAccountRepository
    self.editAccountModel = model
        
    $selectedPickerItem
      .sink { [weak self] item in
        guard let self else { return }
        Task { [weak self] in
          guard let self, item.isNotNil else { return }
          await convertImage(image: item)
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
  
  @MainActor
  func convertImage(image: PhotosPickerItem?) async {
    if let data = try? await image?.loadTransferable(type: Data.self),
       let uiImage = UIImage(data: data)
    {
      selectedImage = uiImage
      let resizedImage = uiImage.resizeImage(targetSize: CGSize(width: 160, height: 160))
      if let jpegData = resizedImage.jpegData(compressionQuality: 0.1) {
        profileModel.image = jpegData.base64EncodedString(options: .lineLength64Characters)
        Console.log("Base64 string created successfully.")
      } else {
        Console.log("Failed to convert image to JPEG.")
      }
    } else {
      Console.log("Failed to convert image to data.")
    }
  }
  
}
