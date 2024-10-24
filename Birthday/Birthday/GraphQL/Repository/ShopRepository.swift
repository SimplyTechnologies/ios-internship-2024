//
//  ShopRepository.swift
//  Birthday
//
//  Created by Narek on 24.10.24.
//

import BirthDayAPI
import Combine
import Foundation

protocol ShopRepository: GraphQLRepository {
  
  func getShops() -> AnyPublisher<[GetShopsQuery.Data.Shop], Error>
  
}

final class ShopDefaultRepository: ShopRepository {
  
  func getShops() -> AnyPublisher<[BirthDayAPI.GetShopsQuery.Data.Shop], any Error> {
    performQuery(query: GetShopsQuery()).compactMap {
      $0.shops
    }.eraseToAnyPublisher()
  }
  
}
