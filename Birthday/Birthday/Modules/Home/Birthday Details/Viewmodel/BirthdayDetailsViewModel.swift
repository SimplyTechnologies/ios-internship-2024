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
  
  private var homeRepository: HomeRepository
  private var cancelables = Set<AnyCancellable>()
  
  init(homeRepository: HomeRepository) {
    self.homeRepository = homeRepository
  }
  
  func updateBirthday(payload: BirthdayUpdatePayload) {
    isLoading = true
    homeRepository.updateBirhday(payload: payload)
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .failure(let error):
          print(error)
        default: break
        }
      } receiveValue: { update in
        print(update)
      }.store(in: &cancelables)
  }
  
  func deleteBirthDay(id: Int) {
    isLoading = true
    homeRepository.deleteBirthday(id: id)
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .failure(let error):
          print(error)
        default: break
        }
      } receiveValue: { id in
        print(id)
      }.store(in: &cancelables)
  }
  
}
