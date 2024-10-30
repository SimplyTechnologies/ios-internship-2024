//
//  ChangePasswordRepository.swift
//  Birthday
//
//  Created by Narek on 28.10.24.
//

import BirthDayAPI
import Combine
import Foundation

protocol ChangePasswordRepository: GraphQLRepository {
  
  func changePassword(oldPassword: String, newPassword: String) -> AnyPublisher<ChangePasswordMutation.Data, Error>
  
}

final class ChangePasswordDefaultRepository: ChangePasswordRepository {
  
  func changePassword(oldPassword: String, newPassword: String) -> AnyPublisher<BirthDayAPI.ChangePasswordMutation.Data, any Error> {
    performMutation(
      mutation: ChangePasswordMutation(
        changePasswordInput: ChangePasswordInput(
          newPassword: newPassword,
          oldPassword: oldPassword
        )
      )
    )
    .eraseToAnyPublisher()
  }
  
}
