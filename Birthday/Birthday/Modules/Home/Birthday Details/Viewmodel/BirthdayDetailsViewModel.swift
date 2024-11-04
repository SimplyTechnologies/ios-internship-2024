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
  @Published var selectedItem: PhotosPickerItem?
  @Published var isShowMessage: Bool = false
  @Published var isDeleting: Bool = false
  
  let id: UUID = UUID()
  var deleteAction: () -> ()
  var updateAction: (BirthdayModel) -> ()
  var toastMessage: String = ""
  var isSuccessMessage: Bool = false
  
  private let homeRepository: HomeRepository
  private var cancelables = Set<AnyCancellable>()
  
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
  }
  
  func updateBirthday() {
    isLoading = true
    isShowMessage = false
    guard let id = birthdayData.id else { return }
    let payload = BirthdayUpdatePayload(
      id: id,
      image: birthdayData.image,
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
        self.birthdayData.image = update.image
        showToast(message: String.Toast.updateBirthday, isSuccess: true)
        self.updateAction(self.birthdayData)
      }
      .store(in: &cancelables)
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
      .store(in: &cancelables)
  }
  
  @MainActor
  func convertImage(image: PhotosPickerItem?) async {
    if let data = try? await image?.loadTransferable(type: Data.self),
       let uiImage = UIImage(data: data)
    {
      selectedImage = uiImage
      let resizedImage = uiImage.resizeImage(targetSize: CGSize(width: 100, height: 100))
      if let jpegData = resizedImage.jpegData(compressionQuality: 0.1) {
        birthdayData.image = jpegData.base64EncodedString(options: .lineLength64Characters)
        Console.log("Base64 string created successfully.")
      } else {
        Console.log("Failed to convert image to JPEG.")
      }
    } else {
      Console.log("Failed to convert image to data.")
    }
  }
  
}
