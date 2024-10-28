//
//  SignInRepository.swift
//  Birthday
//
//  Created by Narek on 28.10.24.
//

import Foundation
import Combine
import BirthDayAPI

protocol SignInRepository: GraphQLRepository {
  
  func singIn(email: String, password: String) -> AnyPublisher<SignInMutation.Data, Error>
  
}

final class SignInDefaultRepository: SignInRepository {
  
  func singIn(email: String, password: String) -> AnyPublisher<BirthDayAPI.SignInMutation.Data, any Error> {
    performMutation(
      mutation: SignInMutation(
        loginInput: LoginInput(
          email: email,
          password: password
        )
      )
    )
    .eraseToAnyPublisher()
  }
  
}
