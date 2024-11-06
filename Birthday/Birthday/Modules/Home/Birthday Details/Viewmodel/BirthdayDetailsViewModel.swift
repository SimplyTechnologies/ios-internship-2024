//
//  BirthdayDetailsViewModel.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 23.10.24.
//

import Combine
import Foundation
import PhotosUI
import SwiftUI

final class BirthdayDetailsViewModel: BirthDayDetailsViewModeling {
  
  @Published var isLoading: Bool = false
  @Published var birthdayData: BirthdayModel
  @Published var isEditing: Bool = false
  @Published var isGeneratingMessage: Bool = false
  @Published var selectedImage: UIImage?
  @Published var isShowMessage: Bool = false
  @Published var isDeleting: Bool = false
  @Published var isDoneActive: Bool = false
  @Published var isPickerPresented = false
  @Published var isShowPickerOptions = false
  @Published var selectedSourceType: UIImagePickerController.SourceType = .photoLibrary
  
  let id: UUID = UUID()
  var deleteAction: () -> ()
  var updateAction: (BirthdayModel) -> ()
  var toastMessage: String = ""
  var isSuccessMessage: Bool = false
  var birthdayCopy: BirthdayModel
  
  private let homeRepository: HomeRepository
  private var cancellables = Set<AnyCancellable>()
  
  init(
    homeRepository: HomeRepository,
    birthdayData: BirthdayModel,
    deleteAction: @escaping () -> (),
    updateAction: @escaping (BirthdayModel) -> ()
  ) {
    self.homeRepository = homeRepository
    self.birthdayData = birthdayData
    self.deleteAction = deleteAction
    self.updateAction = updateAction
    self.birthdayCopy = birthdayData
    
    validateDoneButton()
    convertImageOnChange()
  }
  
  private func convertImageOnChange() {
    $selectedImage
      .sink { [weak self] image in
        guard let self, let image else { return }
        image.convertToBase64 { [weak self] error, base64String in
          guard let self else { return }
          birthdayData.image = base64String
        }
      }
      .store(in: &cancellables)
  }
  
  func updateBirthday() {
    isLoading = true
    isShowMessage = false
    guard let id = birthdayData.id else { return }
    let payload = BirthdayUpdatePayload(
      id: id,
      image: selectedImage == nil ? nil : birthdayData.image,
      name: birthdayData.name,
      date: birthdayData.date,
      message: birthdayData.message,
      relation: birthdayData.relation?.rawValue
    )
    homeRepository.updateBirhday(payload: payload)
      .sink { [weak self] result in
        guard let self else { return }
        isLoading = false
        switch result {
        case .failure(let error):
          Console.log("❌ Error: ", error)
          showToast(message: error.localizedDescription, isSuccess: false)
        default: break
        }
      } receiveValue: { [weak self] update in
        guard let self else { return }
        if update.image != nil {
          self.birthdayData.image = update.image
        }
        showToast(message: String.Toast.updateBirthday, isSuccess: true)
        self.updateAction(self.birthdayData)
      }
      .store(in: &cancellables)
  }
  
  func deleteBirthDay(id: Int, complition: @escaping () -> ()) {
    isDeleting = true
    isLoading = true
    isShowMessage = false
    homeRepository.deleteBirthday(id: id)
      .sink { [weak self] result in
        guard let self else { return }
        self.isLoading = false
        self.isDeleting = false
        switch result {
        case .failure(let error):
          Console.log("❌ Error: ", error)
          showToast(message: error.localizedDescription, isSuccess: false)
        default: break
        }
      } receiveValue: { [weak self] id in
        guard let self else { return }
        print(id)
        Console.log("Deleted id: ", id)
        showToast(message: String.Toast.deleteBirthday, isSuccess: true)
        deleteAction()
        complition()
      }
      .store(in: &cancellables)
  }
  
  private func validateDoneButton() {
    $birthdayData
      .map {
        !($0 == self.birthdayCopy && self.selectedImage == nil)
      }
      .assign(to: &$isDoneActive)
  }
  
  func cancelEdit() {
    withAnimation {
      isEditing = false
      birthdayData = birthdayCopy
      selectedImage = nil
    }
  }
  
}
