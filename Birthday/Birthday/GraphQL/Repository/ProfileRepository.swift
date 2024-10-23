//
//  ProfileRepository.swift
//  Birthday
//
//  Created by Anna Hakobyan on 23.10.24.
//

import Foundation
import Combine
import BirthDayAPI

protocol ProfileRepository: GraphQLRepository {
  
  func getProfile() -> AnyPublisher<GetProfileQuery.Data.Profile, Error>
  
}

final class ProfileDefaultRepository: ProfileRepository {
  
  func getProfile() -> AnyPublisher<GetProfileQuery.Data.Profile, Error> {
    performQuery(query: GetProfileQuery()).compactMap {
      $0.profile
    }.eraseToAnyPublisher()
  }
  
}
