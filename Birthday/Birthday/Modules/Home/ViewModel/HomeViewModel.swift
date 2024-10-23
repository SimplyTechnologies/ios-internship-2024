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
  @Published var birthdayData: [BirthdayModel] = []
  
  private let homeRepository: HomeRepository
  private var cancelables = Set<AnyCancellable>()
  
  init(homeRepository: HomeRepository) {
    self.homeRepository = homeRepository
  }
  
  func getBirthDays() {
    isLoading = true
    homeRepository.getBirthdays()
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .failure(let error):
          print(error)
        default: break
        }
      } receiveValue: { [weak self] birtdays in
        birtdays.forEach {
          self?.birthdayData.append(BirthdayModel(dto: $0))
        }
      }.store(in: &cancelables)
  }
  
}
