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
  func addToFavorite(_ shopId: Int) -> AnyPublisher<AddShopToFavoriteMutation.Data, Error>
  func removeFromFavorites(_ shopId: Int) -> AnyPublisher<RemoveShopFromeFavoriteMutation.Data, Error>
  
}

final class ShopDefaultRepository: ShopRepository {
  
  func getShops() -> AnyPublisher<[BirthDayAPI.GetShopsQuery.Data.Shop], any Error> {
    performQuery(query: GetShopsQuery()).compactMap {
      $0.shops
    }
    .eraseToAnyPublisher()
  }
  
  func addToFavorite(_ shopId: Int) -> AnyPublisher<BirthDayAPI.AddShopToFavoriteMutation.Data, any Error> {
    performMutation(
      mutation: AddShopToFavoriteMutation(shopId: shopId)
    )
    .eraseToAnyPublisher()
  }
  
  func removeFromFavorites(_ shopId: Int) -> AnyPublisher<BirthDayAPI.RemoveShopFromeFavoriteMutation.Data, any Error> {
    performMutation(
      mutation: RemoveShopFromeFavoriteMutation(shopId: shopId)
    )
    .eraseToAnyPublisher()
  }

}
