//
//  GraphQLRepository.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 21.10.24.
//

import Foundation
import ApolloAPI
import Apollo

class GraphQLRepository {
    let apollo: ApolloClient
    
    init(apollo: ApolloClient) {
        self.apollo = apollo
    }
    
    func performQuery<T: GraphQLQuery>(query: T, completion: @escaping (Result<T.Data, Error>) -> Void) {
        apollo.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResult):
                if let data = graphQLResult.data {
                    completion(.success(data))
                } else if let error = graphQLResult.errors?.first {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func performMutation<T: GraphQLMutation>(mutation: T, completion: @escaping (Result<T.Data, Error>) -> Void) {
        apollo.perform(mutation: mutation) { result in
            switch result {
            case .success(let graphQLResult):
                if let data = graphQLResult.data {
                    completion(.success(data))
                } else if let error = graphQLResult.errors?.first {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
