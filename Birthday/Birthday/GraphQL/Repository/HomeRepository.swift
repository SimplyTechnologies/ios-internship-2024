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
  func updateBirhday(payload: BirthdayUpdatePayload) -> AnyPublisher<UpdateBirthdayMutation.Data.UpdateBirthday, Error>
  func deleteBirthday(id: Int) -> AnyPublisher<Int, Error>
  
}

final class HomeDefaultRepository: HomeRepository {
  
  func getBirthdays() -> AnyPublisher<[GetBirthDayListQuery.Data.Birthday], Error> {
    performQuery(query: GetBirthDayListQuery()).compactMap {
      $0.birthdays
    }
    .eraseToAnyPublisher()
  }
  
  func updateBirhday(payload: BirthdayUpdatePayload) -> AnyPublisher<BirthDayAPI.UpdateBirthdayMutation.Data.UpdateBirthday, Error> {
    let input =
    UpdateBirthdayInput(
      date: makeNullable(from: payload.date) ?? nil,
      image: makeNullable(from: payload.image) ?? nil,
      message: makeNullable(from: payload.message) ?? nil,
      name: makeNullable(from: payload.name) ?? nil,
      relation: makeNullable(from: payload.relation) ?? nil
    )
    return performMutation(mutation: UpdateBirthdayMutation(id: payload.id, updateBirthdayInput: input))
      .compactMap {
        $0.updateBirthday
      }
      .eraseToAnyPublisher()
  }
  
  func deleteBirthday(id: Int) -> AnyPublisher<Int, Error> {
    performMutation(mutation: DeleteBirthDayMutation(id: id)).compactMap {
      $0.deleteBirthday.id
    }
    .eraseToAnyPublisher()
  }
  
}
