//
//  ShopDetailsViewModel.swift
//  Birthday
//
//  Created by Narek on 25.10.24.
//

import Combine
import SwiftUI

final class ShopDetailsViewModel: ShopDetailsViewModeling {
  
  @Published var isLoading: Bool = false
  @Published var shop: Shop
  
  var id: UUID
  
  private let shopRepository: ShopRepository
  private var cancellables = Set<AnyCancellable>()
  
  init(shopRepository: ShopRepository, shop: Shop) {
    self.shopRepository = shopRepository
    self.shop = shop
    self.id = UUID()
  }
  
}
