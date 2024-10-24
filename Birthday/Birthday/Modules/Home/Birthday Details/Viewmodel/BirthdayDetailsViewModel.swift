//
//  BirthdayDetailsViewModel.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 23.10.24.
//

import Foundation
import Combine

final class BirthdayDetailsViewModel: BirthDayDetailsViewModeling {
  
  @Published var router: any Routable
  @Published var isLoading: Bool = false
  
  private let homeRepository: HomeRepository
  private var cancelables = Set<AnyCancellable>()
  var deleteAction: () -> ()
  var updateAction: (BirthdayModel) -> ()
  
  init(homeRepository: HomeRepository, router: any Routable, deleteAction: @escaping () -> (), updateAction: @escaping (BirthdayModel) -> ()) {
    self.homeRepository = homeRepository
    self.deleteAction = deleteAction
    self.updateAction = updateAction
    self.router = router
  }
  
  func updateBirthday(payload: BirthdayUpdatePayload, birthday: BirthdayModel) {
    isLoading = true
    homeRepository.updateBirhday(payload: payload)
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .failure(let error):
          print(error)
        default: break
        }
      } receiveValue: { [weak self] update in
        self?.updateAction(birthday)
      }.store(in: &cancelables)
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
      }.store(in: &cancelables)
  }
  
}
