//
//  ForgetPasswordRepository.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 29.10.24.
//

import Foundation
import Combine
import BirthDayAPI

protocol ForgotPasswordRepository: GraphQLRepository {
  
  func getCode(email: String) -> AnyPublisher<String, Error>
  func confirmCode(payload: ResetPasswordPayload) -> AnyPublisher<Bool, Error>
  
}

final class ForgotPasswordDefaultRepository: ForgotPasswordRepository {
  
  func getCode(email: String) -> AnyPublisher<String, Error> {
    performMutation(
      mutation:
        ResetPasswordEmailMutation(
          forgotPasswordInput: ForgotPasswordInput(email: email)
        )
    )
    .compactMap {
      $0.forgotPassword
    }
    .eraseToAnyPublisher()
  }
  
  func confirmCode(payload: ResetPasswordPayload) -> AnyPublisher<Bool, Error> {
    performMutation(
      mutation:
        ResetPasswordMutation(
          resetPasswordInput:
            ResetPasswordInput(
              hash: payload.code,
              password: payload.password,
              passwordConfirm: payload.confirmPassword
            )
        )
    )
    .compactMap {
      $0.resetPassword
    }
    .eraseToAnyPublisher()
  }
  
}
