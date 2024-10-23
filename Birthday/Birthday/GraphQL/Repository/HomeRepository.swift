//
//  HomeRepository.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import Foundation
import Combine
import BirthDayAPI

protocol HomeRepository: GraphQLRepository {
  
  func getBirthdays() -> AnyPublisher<[GetBirthDayListQuery.Data.Birthday], Error>
  
}

final class HomeDefaultRepository: HomeRepository {
  
  func getBirthdays() -> AnyPublisher<[GetBirthDayListQuery.Data.Birthday], Error> {
    performQuery(query: GetBirthDayListQuery()).compactMap {
      $0.birthdays
    }.eraseToAnyPublisher()
  }
  
}
