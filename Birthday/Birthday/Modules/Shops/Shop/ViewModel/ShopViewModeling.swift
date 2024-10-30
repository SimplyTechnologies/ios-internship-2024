//
//  ShopViewModeling.swift
//  Birthday
//
//  Created by Narek on 24.10.24.
//

import Foundation

protocol ShopViewModeling: ObservableObject {
  
  var isLoading: Bool { get set }
  var shops: [Shop] { get set }
  var filteredShops: [Shop] { get set }
  var isFocused: Bool { get set }
  var searchText: String { get set }
  
  var id: UUID { get set }
  
  func getShops()
  func toggleFavorite(shop: Shop)
  
}
