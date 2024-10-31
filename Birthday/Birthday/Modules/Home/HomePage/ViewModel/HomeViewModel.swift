//
//  HomeViewModel.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import Foundation
import Combine
import SwiftUI

final class HomeViewModel: HomeViewModeling {
  
  @Published var isLoading: Bool = false
  @Published var birthdayData: [BirthdayModel] = []
  
  private let homeRepository: HomeRepository
  private var cancelables = Set<AnyCancellable>()
  
  init(homeRepository: HomeRepository) {
    self.homeRepository = homeRepository
    subscribeForNewBirthdays()
  }
  
  func getBirthDays() {
    withAnimation {
      isLoading = true
    }
    homeRepository.getBirthdays()
      .sink { [weak self] result in
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
          withAnimation {
            self?.isLoading = false
          }
        }
        switch result {
        case .failure(let error):
          Console.log(error)
        default: break
        }
      } receiveValue: { [weak self] birtdays in
        self?.birthdayData = []
        birtdays.forEach {
          self?.birthdayData.append(BirthdayModel(dto: $0))
        }
      }
      .store(in: &cancelables)
  }
  
  func subscribeForNewBirthdays() {
    BirthdayPublisher.publisher.sink { [weak self] newBirthday in
      self?.birthdayData.append(newBirthday)
    }
    .store(in: &cancelables)
  }
  
}
