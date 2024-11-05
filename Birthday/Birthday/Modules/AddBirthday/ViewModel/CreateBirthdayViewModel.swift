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
  @Published var isShowMessage: Bool = false
  @Published var isPickerPresented = false
  @Published var isShowPickerOptions = false
  @Published var selectedSourceType: UIImagePickerController.SourceType = .photoLibrary
  
  var toastMessage: String = ""
  var isSuccessMessage: Bool = false
  @Published var birthday: BirthdayModel = BirthdayModel()
  
  private let newBirthdayRepository: NewBirthdayRepository
  private var cancellables = Set<AnyCancellable>()
  
  init(newBirthdayRepository: NewBirthdayRepository) {
    self.newBirthdayRepository = newBirthdayRepository
    setupContentValidation()
    convertImageOnChange()
  }
  
  private func setupContentValidation() {
    $birthday
      .map { birthday in
        !(birthday.name?.isEmpty ?? true) && birthday.date != nil && birthday.relation != nil
      }
      .assign(to: &$isContentValid)
  }
  
  private func convertImageOnChange() {
    $selectedImage
      .sink { [weak self] image in
        guard let self, let image else { return }
        image.convertToBase64 { [weak self] error, base64String in
          guard let self else { return }
          birthday.image = base64String
        }
      }
      .store(in: &cancellables)
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
        self.selectedImage = nil
        showToast(message: String.Toast.createBirthday, isSuccess: true)
      }.store(in: &cancellables)
  }
  
  func resetScreen() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
      guard let self else { return }
      birthday = BirthdayModel()
      selectedImage = nil
    }
  }
  
}
