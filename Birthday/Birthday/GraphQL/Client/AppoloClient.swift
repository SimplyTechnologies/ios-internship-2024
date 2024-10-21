//
//  AppoloClient.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 21.10.24.
//

import Foundation
import Apollo

class Network {
    
    static let shared = Network()
    
    private(set) lazy var apollo: ApolloClient = {
        let url = URL(string: "https://birthdayapp.store/graphql")!
        return ApolloClient(url: url)
    }()
    
}
