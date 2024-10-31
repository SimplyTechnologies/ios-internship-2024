//
//  CreateBirthdayViewModel.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 26.10.24.
//

import Combine
import Foundation
import PhotosUI
import SwiftUI

final class CreateBirthdayViewModel: CreateBirthdayViewModeling {
  
  @Published var isContentValid: Bool = false
  @Published var isLoading: Bool = false
  @Published var selectedImage: UIImage? = nil
  @Published var selectedItem: PhotosPickerItem? = nil
  @Published var isShowMessage: Bool = false
  
  var toastMessage: String = ""
  var isSuccessMessage: Bool = false
  @Published var birthday: BirthdayModel = BirthdayModel()
  
  private let newBirthdayRepository: NewBirthdayRepository
  private var cancelables = Set<AnyCancellable>()
  
  init(newBirthdayRepository: NewBirthdayRepository) {
    self.newBirthdayRepository = newBirthdayRepository
    setupContentValidation()
  }
  
  private func setupContentValidation() {
    $birthday
      .map { birthday in
        !(birthday.name?.isEmpty ?? true) && birthday.date != nil && birthday.relation != nil
      }
      .assign(to: &$isContentValid)
  }
  
  func createBirthday() {
    isLoading = true
    isShowMessage = false
    guard let name = birthday.name, let date = birthday.date, let relation = birthday.relation else { return }
    let payload = CreateBirthdayPayload(
      message: birthday.message,
      name: name,
      relation: relation.rawValue,
      date: date,
      image: birthday.image
    )
    newBirthdayRepository.createBirthday(payload: payload)
      .sink { [weak self] result in
        guard let self else { return }
        isLoading = false
        switch result {
        case .failure(let error):
          Console.log("❌ Error: ", error)
          showToast(message: error.localizedDescription, isSuccess: false)
        default: break
        }
      } receiveValue: { [weak self] birthday in
        guard let self else { return }
        let newBirthday = BirthdayModel(createBirthdayDTO: birthday)
        BirthdayPublisher.publisher.send(newBirthday)
        self.birthday = BirthdayModel()
        self.selectedItem = nil
        self.selectedImage = nil
        showToast(message: String.Toast.createBirthday, isSuccess: true)
      }.store(in: &cancelables)
  }
  
  @MainActor
  func convertImage(image: PhotosPickerItem?) async {
    if let data = try? await image?.loadTransferable(type: Data.self),
       let uiImage = UIImage(data: data)
    {
      selectedImage = uiImage
      let resizedImage = uiImage.resizeImage(targetSize: CGSize(width: 100, height: 100))
      if let jpegData = resizedImage.jpegData(compressionQuality: 0.1) {
        birthday.image = jpegData.base64EncodedString(options: .lineLength64Characters)
        Console.log("Base64 string created successfully.")
      } else {
        Console.log("Failed to convert image to JPEG.")
      }
    } else {
      Console.log("Failed to convert image to data.")
    }
  }
  
  func resetScreen() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
      guard let self else { return }
      birthday = BirthdayModel()
      selectedItem = nil
      selectedImage = nil
    }
  }
  
}
