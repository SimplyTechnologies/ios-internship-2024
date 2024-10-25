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
  
  func singUp(_ registrationPayload: RegistrationPayload) -> AnyPublisher<SignUpMutation.Data, Error>
  
}

final class RegistrationDefaultRepository: RegistrationRepository {
  
  func singUp(_ registrationPayload: RegistrationPayload) -> AnyPublisher<BirthDayAPI.SignUpMutation.Data, any Error> {
    performMutation(
      mutation: SignUpMutation(
        signUpInput: SignUpInput(
          email: registrationPayload.email,
          firstName: registrationPayload.firstName,
          lastName: registrationPayload.lastName,
          password: registrationPayload.password
        )
      )
    )
    .eraseToAnyPublisher()
  }
  
}
