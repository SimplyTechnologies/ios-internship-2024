//
//  CreateBirthdayViewModel.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 26.10.24.
//

import Foundation
import Combine
import _PhotosUI_SwiftUI

final class CreateBirthdayViewModel: CreateBirthdayViewModeling {
  
  @Published var isContentValid: Bool = false
  @Published var isLoading: Bool = false
  @Published var selectedImage: UIImage? = nil
  @Published var selectedItem: PhotosPickerItem? = nil
  @Published var birtday: BirthdayModel = BirthdayModel(
    createdAt: nil,
    date: nil,
    id: nil,
    image: nil,
    message: nil,
    name: nil,
    relation: nil,
    upcomingAge: nil,
    upcomingBirthday: nil,
    updatedAt: nil,
    userId: nil
  )
  
  private let newBirthdayRepository: NewBirthdayRepository
  private var cancelables = Set<AnyCancellable>()
  
  init(newBirthdayRepository: NewBirthdayRepository) {
    self.newBirthdayRepository = newBirthdayRepository
    setupContentValidation()
  }
  
  private func setupContentValidation() {
    $birtday
      .map { birthday in
        birthday.name != nil && birthday.date != nil && birthday.relation != nil
      }
      .assign(to: &$isContentValid)
  }
  
  func createBirthday() {
    isLoading = true
    guard let name = birtday.name, let date = birtday.date, let relation = birtday.relation else { return }
    let payload = CreateBirthdayPayload(
      message: birtday.message,
      name: name,
      relation: relation.rawValue,
      date: date,
      image: birtday.image
    )
    newBirthdayRepository.createBirthday(payload: payload)
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .failure(let error):
          print(error)
        default: break
        }
      } receiveValue: { [weak self] birthday in
        guard let self else { return }
        print(birthday)
        self.birtday = BirthdayModel(
          createdAt: nil,
          date: nil,
          id: nil,
          image: nil,
          message: nil,
          name: nil,
          relation: nil,
          upcomingAge: nil,
          upcomingBirthday: nil,
          updatedAt: nil,
          userId: nil
        )
      }.store(in: &cancelables)
  }
  
  func convertImage(image: PhotosPickerItem?) async {
    if let data = try? await image?.loadTransferable(type: Data.self),
       let uiImage = UIImage(data: data) {
      selectedImage = uiImage
      let resizedImage = uiImage.resizeImage(targetSize: CGSize(width: 100, height: 100))
      if let jpegData = resizedImage.jpegData(compressionQuality: 0.1) {
        birtday.image = jpegData.base64EncodedString(options: .lineLength64Characters)
        Console.log("Base64 string created successfully.")
      } else {
        Console.log("Failed to convert image to JPEG.")
      }
    } else {
      Console.log("Failed to convert image to data.")
    }
  }
  
  
}
