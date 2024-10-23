//
//  AppoloClient.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 21.10.24.
//

import Foundation
import Apollo
import ApolloAPI

class AuthInterceptor: ApolloInterceptor {
  
  var id: String = "id"
  
  private var accessToken: String {
    //MARK: - Change this to get from userdefaults when registration is ready
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwicm9sZSI6InVzZXIiLCJpYXQiOjE3Mjk1ODg0MDgsImV4cCI6MTczMjE4MDQwOH0.jLSwpHpEvWfpTELpSQfmk2Atc2TIpmumEwO5vYrCMY0"
  }
  
  func interceptAsync<Operation: GraphQLOperation>(
    chain: RequestChain,
    request: HTTPRequest<Operation>,
    response: HTTPResponse<Operation>?,
    completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
  ) {
    request.addHeader(name: "Authorization", value: "Bearer \(accessToken)")
    chain.proceedAsync(request: request, response: response, completion: completion)
  }
  
}


class Network {
  
  static let shared = Network()
  
  private(set) lazy var apollo: ApolloClient = {
    let url = URL(string: "https://birthdayapp.store/graphql")!
    let store = ApolloStore(cache: InMemoryNormalizedCache())
    let transport = RequestChainNetworkTransport(interceptorProvider: CustomInterceptorProvider(store: store), endpointURL: url)
    return ApolloClient(networkTransport: transport, store: store)
  }()
  
}

class CustomInterceptorProvider: InterceptorProvider {
  
  private let interceptors: [ApolloInterceptor]
  private let sessionClient: URLSessionClient
  
  init(store: ApolloStore) {
    self.sessionClient = URLSessionClient()
    
    self.interceptors = [
      AuthInterceptor(),
      MaxRetryInterceptor(),
      CacheReadInterceptor(store: store),
      NetworkFetchInterceptor(client: sessionClient),
      ResponseCodeInterceptor(),
      AutomaticPersistedQueryInterceptor(),
      MultipartResponseParsingInterceptor(),
      JSONResponseParsingInterceptor(),
      CacheWriteInterceptor(store: store)
    ]
  }
  
  func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
    return interceptors
  }
  
}



