//
//  ProfileRepository.swift
//  Birthday
//
//  Created by Anna Hakobyan on 23.10.24.
//

import Foundation
import Combine
import BirthDayAPI

protocol EditAccountRepository: GraphQLRepository {
  func updateProfile(input: UpdateProfileInput) -> AnyPublisher<UpdateProfileMutation.Data.UpdateProfile, Error>
}

final class EditAccountDefaultRepository: EditAccountRepository {
  
  func updateProfile(input: UpdateProfileInput) -> AnyPublisher<UpdateProfileMutation.Data.UpdateProfile, Error> {
    let mutation = UpdateProfileMutation(updateProfileInput: input)

    return performMutation(mutation: mutation)
      .tryMap { result in
        result.updateProfile
      }
      .eraseToAnyPublisher()
  }

}
