//
//  NewBirthdayRepository.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 26.10.24.
//

import Foundation
import Combine
import BirthDayAPI

protocol NewBirthdayRepository: GraphQLRepository {
  
  func createBirthDay(payload: CreateBirthdayPayload) -> AnyPublisher<CreateBirthdayMutation.Data.CreateBirthday, Error>
  
}

final class NewBirthdayDefaultRepository: NewBirthdayRepository {
  
  func createBirthDay(payload: CreateBirthdayPayload) -> AnyPublisher<CreateBirthdayMutation.Data.CreateBirthday, Error> {
    let input = CreateBirthdayInput(
      date: payload.date,
      image: makeNullable(from: payload.image) ?? nil,
      message: makeNullable(from: payload.message) ?? nil,
      name: payload.name,
      relation: payload.relation
    )
    return performMutation(mutation: CreateBirthdayMutation(createBirthdayInput: input))
      .compactMap {
        $0.createBirthday
      }
      .eraseToAnyPublisher()
  }
  
}
