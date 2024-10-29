//
//  BirthdayDetailsViewModel.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 23.10.24.
//

import Foundation
import Combine

final class BirthdayDetailsViewModel: BirthDayDetailsViewModeling {
  
  @Published var isLoading: Bool = false
  @Published var birthdayData: BirthdayModel
  @Published var isEditing: Bool = false
  @Published var isGeneratingMessage: Bool = false
  
  private let homeRepository: HomeRepository
  private var cancelables = Set<AnyCancellable>()
  
  var id: UUID
  var deleteAction: () -> ()
  var updateAction: (BirthdayModel) -> ()
  
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
    self.id = UUID()
  }
  
  func updateBirthday() {
    isLoading = true
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
        self?.isLoading = false
        switch result {
        case .failure(let error):
          print(error)
        default: break
        }
      } receiveValue: { [weak self] update in
        guard let self else { return }
        self.updateAction(self.birthdayData)
      }
      .store(in: &cancelables)
  }
  
  func deleteBirthDay(id: Int, complition: @escaping () -> ()) {
    isLoading = true
    homeRepository.deleteBirthday(id: id)
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .failure(let error):
          print(error)
        default: break
        }
      } receiveValue: { [weak self] id in
        print(id)
        self?.deleteAction()
        complition()
      }
      .store(in: &cancelables)
  }
  
}
