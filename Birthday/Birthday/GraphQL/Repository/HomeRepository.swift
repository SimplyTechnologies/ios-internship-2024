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
    }.eraseToAnyPublisher()
  }
  
  func updateBirhday(payload: BirthdayUpdatePayload) -> AnyPublisher<BirthDayAPI.UpdateBirthdayMutation.Data.UpdateBirthday, Error> {
    let input = 
    UpdateBirthdayInput(
      date: payload.date != nil ? GraphQLNullable(stringLiteral: payload.date!) : nil,
      image: payload.image != nil ? GraphQLNullable(stringLiteral: payload.image!) : nil,
      message: payload.message != nil ? GraphQLNullable(stringLiteral: payload.message!) : nil,
      name: payload.name != nil ? GraphQLNullable(stringLiteral: payload.name!) : nil,
      relation: payload.relation != nil ? GraphQLNullable(stringLiteral: payload.relation!) : nil)
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
