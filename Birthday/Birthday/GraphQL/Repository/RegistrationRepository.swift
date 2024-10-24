//
//  RegistrationRepository.swift
//  Birthday
//
//  Created by Narek on 23.10.24.
//

import Foundation
import Combine
import BirthDayAPI

protocol RegistrationRepository: GraphQLRepository {
  
  func singUp(
    firstName: String,
    lastName: String,
    email: String,
    password: String
  ) -> AnyPublisher<SignUpMutation.Data, Error>
  
}

final class RegistrationDefaultRepository: RegistrationRepository {
  
  func singUp(
    firstName: String,
    lastName: String,
    email: String,
    password: String
  ) -> AnyPublisher<BirthDayAPI.SignUpMutation.Data, any Error> {
    performMutation(
      mutation: SignUpMutation(
        signUpInput: SignUpInput(
          email: email,
          firstName: firstName,
          lastName: lastName,
          password: password
        )
      )
    )
    .eraseToAnyPublisher()
  }
  
}
