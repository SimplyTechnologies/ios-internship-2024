//
//  HomeViewModel.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import Foundation
import Combine

final class HomeViewModel: HomeViewModeling {
  
  @Published var isLoading: Bool = false
  @Published var error: Error? = nil
  @Published var birthDays: [BirthdayModel] = []
  
  private var homeRepository: HomeRepository
  private var cancelables = Set<AnyCancellable>()
  
  init(homeRepository: HomeRepository) {
    self.homeRepository = homeRepository
  }
  
  func getBirthDays() {
    isLoading = true
    homeRepository.getBirthdays()
      .sink { [weak self] result in
        switch result {
        case .finished:
          self?.isLoading = false
        case.failure(let error):
          print(error)
        }
      } receiveValue: { birtdays in
        birtdays.forEach {
          self.birthDays.append(BirthdayModel(dto: $0))
        }
      }.store(in: &cancelables)
  }
  
}
