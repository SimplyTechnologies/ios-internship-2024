//
//  GraphQLRepository.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 21.10.24.
//

import Foundation
import ApolloAPI
import Apollo
import Combine

protocol GraphQLRepository  { }

extension GraphQLRepository {
  
  func performQuery<T: GraphQLQuery>(query: T) -> AnyPublisher<T.Data, Error> {
    Future { promise in
      Network.shared.apollo.fetch(query: query) { result in
        switch result {
        case .success(let graphQLResult):
          if let data = graphQLResult.data {
            promise(.success(data))
          } else if let error = graphQLResult.errors?.first {
            promise(.failure(error))
          }
        case .failure(let error):
          promise(.failure(error))
        }
      }
    }.eraseToAnyPublisher()
  }
  
  func performMutation<T: GraphQLMutation>(mutation: T) -> AnyPublisher<T.Data, Error> {
    Future { promise in
      Network.shared.apollo.perform(mutation: mutation) { result in
        switch result {
        case .success(let graphQLResult):
          if let data = graphQLResult.data {
            promise(.success(data))
          } else if let error = graphQLResult.errors?.first {
            promise(.failure(error))
          }
        case .failure(let error):
          promise(.failure(error))
        }
      }
    }.eraseToAnyPublisher()
  }
  
}
